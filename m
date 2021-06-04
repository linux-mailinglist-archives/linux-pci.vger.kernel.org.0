Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F047339B9E8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFDNeg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 09:34:36 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:34402 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhFDNef (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 09:34:35 -0400
Received: by mail-qk1-f176.google.com with SMTP id k11so7648242qkk.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 06:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zA3/cfdzVIr5cLh/J+wg9gDOYGj6S6m5ZJD71R+yPk4=;
        b=QV1DBlfPSuBi7PYdWjytjArbkBrMojbPdTYRqwQhI8zaMowCyIwQjgXsAftiPpkQgH
         QUlfpzaYHiwnVMgD8M8t1kI290rRXwoMv2QRJAZT7JipMZsyfipOt2HSG3EbIs2ZBcAf
         KY1kVZX8pzlR34V4quGGUxbGFEkHcnlKSM21KAU8aj9dUq/oakaEGBj6Nfuu/7Pql7KX
         UbZ+ui10pWlkAjLvwPzuuhAxMZKKGfVd/iiH9h9i6TF1LcStFuLDwWirnDUe29O4APzs
         gIruCrigD0JITXK2IjUSWRuD/fabI01TPHHFZ8R+tJu18GjP9uFLMt0QyaOa4EwE/PjY
         HYRg==
X-Gm-Message-State: AOAM533pXL3iYfMy+DPPw60sAWwG0QbRRwKjalCaFWVhhYGifDlLOJxh
        /0b1tlBwXTg61dBRzdvy7t0=
X-Google-Smtp-Source: ABdhPJyIM0cfKjUEdW2OkwQ9ncmanXPqTrSoJWo1H6K6CtRDy7i5ZUIPyVf61zsfzgrbvcH1pRE0NA==
X-Received: by 2002:a05:620a:b1b:: with SMTP id t27mr4331322qkg.42.1622813568937;
        Fri, 04 Jun 2021 06:32:48 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b189sm3965912qkc.91.2021.06.04.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:32:48 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v7 6/6] PCI/sysfs: Fix a buffer overrun problem with dsm_label_utf16s_to_utf8s()
Date:   Fri,  4 Jun 2021 13:32:30 +0000
Message-Id: <20210604133230.983956-7-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604133230.983956-1-kw@linux.com>
References: <20210604133230.983956-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When using ACPI to retrieve a device label from _DSM using the
dsm_get_label() function the result can be retrieved either as a string
value or a pointer to a buffer.

Should it be the latter, then an additional function called
dsm_label_utf16s_to_utf8s() will be invoked to convert any UTF16
characters to UTF8 so that the value could be safely stored and later
displayed through a relevant sysfs object.

Internally, dsm_label_utf16s_to_utf8s() calls the utf16s_to_utf8s()
function to handle the conversion setting the limit of the data that can
be saved into a provided buffer as a result of the character conversion
to be a total of PAGE_SIZE.  The utf16s_to_utf8s() function returns an
integer value denoting the number of bytes that have been written into
the provided buffer.

Following the execution of the utf16s_to_utf8s() a newline character
will be added at the end of the resulting buffer so that when the value
is read in the userspace through the sysfs object then it would include
newline making it more accessible when working with the sysfs file
system in the shell, etc.  Normally, this wouldn't be a problem, but if
the function utf16s_to_utf8s() happens to return the number of bytes
written to be precisely PAGE_SIZE, then we would overrun the buffer and
write the newline character outside the allotted space which can have
undefined consequences or result in a failure.

To fix this buffer overrun, ensure that there always is enough space
left for the newline character to be safely appended.

Fixes: 6058989bad05 ("PCI: Export ACPI _DSM provided firmware instance number and string name to sysfs")
Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci-label.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 000e169c7197..0c6446519640 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -146,8 +146,8 @@ static int dsm_label_utf16s_to_utf8s(union acpi_object *obj, char *buf)
 	len = utf16s_to_utf8s((const wchar_t *)obj->buffer.pointer,
 			      obj->buffer.length,
 			      UTF16_LITTLE_ENDIAN,
-			      buf, PAGE_SIZE);
-	buf[len] = '\n';
+			      buf, PAGE_SIZE - 1);
+	buf[len++] = '\n';
 
 	return len;
 }
-- 
2.31.1

