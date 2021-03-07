Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CF632FE64
	for <lists+linux-pci@lfdr.de>; Sun,  7 Mar 2021 02:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCGBqS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Mar 2021 20:46:18 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:40714 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCGBpw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Mar 2021 20:45:52 -0500
Received: by mail-qk1-f177.google.com with SMTP id l132so6029010qke.7
        for <linux-pci@vger.kernel.org>; Sat, 06 Mar 2021 17:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uuKGPRQK6+AJ65qutu1+4krlaJiK+S0oW3qn/isFq/w=;
        b=gOJQ5lHNo5V89pZZ10yXvEtd44wsKzBRA1cn0wL1q7hDePVJqzXL9zoOaDPDsKuOzX
         CaXXyHjq6cynWPhKN4j6C9eGMRFKicFk0Pnq8ZVu5ROTh8LKcvykhH7YMDarLdu6fplC
         xWXF0jYIFX+Aja09wH9rqQRxYwaGAll2UBXEEXXxUsRNzLU6VleANZ7/J/PK2JOROngL
         j+ZvQGpHwWMj90HCAODG0Jgpk9nQHwBkl1ylg1YKT+uGfOt4r388cJ/IYEnV//wiQBKK
         RotUEk/Nid6CG9PpBa4dykuGIf5EOUkjI8fR1mtMZcyA8zJTTK8S4xmG1oA3BZiFFNR+
         UEUg==
X-Gm-Message-State: AOAM531PZY5HXAKGKHIftQp3xLIR7Q0+jJZt7WqKZuzNmmRQ1aUsumql
        VN5trf2leYmmbc+rhsvQWfM=
X-Google-Smtp-Source: ABdhPJxgBpfo0jIorx1mXIAb4mDU149BaO92iNxIeigr26I5GrAcfywJsfuYyE4TAm5GFFvFBsCd8g==
X-Received: by 2002:a37:a30f:: with SMTP id m15mr15085602qke.433.1615081552274;
        Sat, 06 Mar 2021 17:45:52 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o30sm4928578qkl.17.2021.03.06.17.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 17:45:51 -0800 (PST)
Date:   Sun, 7 Mar 2021 02:45:49 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Dongdong Liu <liudongdong3@huawei.com>
Cc:     mj@ucw.cz, helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND] lspci: Decode VF 10-Bit Tag Requester
Message-ID: <YEQwTRKNmnNk1OY+@rocinante>
References: <1614770048-41209-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1614770048-41209-1-git-send-email-liudongdong3@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[+cc Bjorn who was workingo on making commas usage more consistent]

Thank you for sending the patch over.

> Decode VF 10-Bit Tag Requester Supported and Enable bit
> in SR-IOV Capabilities Register.
> 
> Sample output:
>   IOVCap: Migration-, 10BitTagReq+, Interrupt Message Number: 000
>   IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy- 10BitTagReq+
[...]

Would you be able to move the "10BitTagReq" in the "IOVCtl" after the
"Migration" so that its placement is consistent with the "IOVCap"?  This
would be also along the lines of how the same files is already used in
the ls-caps.c file.

Bjorn was also working on making a lot of the commas usage throughout to
follow the best practice, thus I believe that the commas there would not
be needed.  Having said that, it might be better to follow the current
style present there at the moment.

See 018f413 ("lspci: Use commas more consistently") for more details on
Bjorn's work to normalise the usage of commas.

Additionally, with the new fields, would you also have to update some of
the tests files?  For example:

  Index File                Line Content
      0 tests/cap-dvsec-cxl   81 Capabilities: [b80 v1] Single Root I/O Virtualization (SR-IOV)
      1 tests/cap-dvsec-cxl   82 IOVCap: Migration-, Interrupt Message Number: 000
      2 tests/cap-dvsec-cxl   83 IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
      3 tests/cap-dvsec-cxl   84 IOVSta: Migration-
      4 tests/cap-pcie-2      50 Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
      5 tests/cap-pcie-2      51 IOVCap:  Migration-, Interrupt Message Number: 000
      6 tests/cap-pcie-2      52 IOVCtl:  Enable+ Migration- Interrupt- MSE+ ARIHierarchy-
      7 tests/cap-pcie-2      53 IOVSta:  Migration-
      8 tests/cap-ea-1        59 Capabilities: [180 v1] Single Root I/O Virtualization (SR-IOV)
      9 tests/cap-ea-1        60 IOVCap:  Migration-, Interrupt Message Number: 000
     10 tests/cap-ea-1        61 IOVCtl:  Enable+ Migration- Interrupt- MSE+ ARIHierarchy+
     11 tests/cap-ea-1        62 IOVSta:  Migration-

Otheriwse, it looks good!  Thank you!

Krzysztof
