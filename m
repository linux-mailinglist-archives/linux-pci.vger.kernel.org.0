Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA4C39968F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 02:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFCADH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 20:03:07 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:44936 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhFCADH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 20:03:07 -0400
Received: by mail-wr1-f52.google.com with SMTP id f2so3924353wri.11
        for <linux-pci@vger.kernel.org>; Wed, 02 Jun 2021 17:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zA3/cfdzVIr5cLh/J+wg9gDOYGj6S6m5ZJD71R+yPk4=;
        b=b9En4xt8RpriDfK1+pKQrEsDAXkXPntqXAMxcwy8zIqAX+nL3x1aQb0Ahdd0hVTG8O
         3E38W1eovc1Q//UKeR4IFRe6+eKZArlLTz8lnw91sqiDSUdBh9B20zkjfV1XX6KVqE0V
         b4eh1JAECINfnbSffxJS2a1W+k1Rr20M+J/ON9aKqLcR5ZznpRUWNda70hIfmQOSYveD
         AgzeLwJutXRzGNN2lBa/MxY6494h4sTIwVv/hWlKlViTc2VYlaVs7UIwOofJsUVN4Bh6
         qlgQj/MMwyodglEiMu6r0WZTz8pvMYpggCMEMItjnwVvSplVzP80e28hBvnaD63Ae7l1
         OgaQ==
X-Gm-Message-State: AOAM530cdif/Qj5yv1kj6Xr98Znqh4B7/kAgEmIcf4eqtVPTwRSuzqPN
        kJwyXakjE96zXO9CFUKM4lI=
X-Google-Smtp-Source: ABdhPJwzeVEAwsomDW0efFIz/tfw5FvH3kbiutKwNaOqyd9Ur8akCO3TiSmko1UmxM2s2QJ9lxgKqA==
X-Received: by 2002:a05:6000:180f:: with SMTP id m15mr8739885wrh.60.1622678482563;
        Wed, 02 Jun 2021 17:01:22 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c7sm1424669wrs.23.2021.06.02.17.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 17:01:22 -0700 (PDT)
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
Subject: [PATCH v6 6/6] PCI/sysfs: Fix a buffer overrun problem with dsm_label_utf16s_to_utf8s()
Date:   Thu,  3 Jun 2021 00:01:12 +0000
Message-Id: <20210603000112.703037-7-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603000112.703037-1-kw@linux.com>
References: <20210603000112.703037-1-kw@linux.com>
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

