Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A25C31434D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Feb 2021 23:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBHWym (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Feb 2021 17:54:42 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38789 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhBHWyj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Feb 2021 17:54:39 -0500
Received: by mail-wr1-f54.google.com with SMTP id b3so19152472wrj.5;
        Mon, 08 Feb 2021 14:54:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kS2s2dPI8ytNFZbp+yZg3gpLYqkSZkDa3K+KlRfCscc=;
        b=X6g1SUM14CetOT8E28Ij12tvO3sKdtFYfP4eUdMWrSEnhq5VstpxEFFtEkzI+XE9ct
         xFLCD+BgWInAou/8idYKJ0P+T30+BvANod/UiKtxb6Nvvw4QcVcv79Zn3ORoMVr5XbjX
         tzC4pMtH9g/WIE+iLFmvJAeZBbuOeoz4LIiGTgTCA+Gz2p80EAzAFPgwN2Oi5G3A8ZzM
         tB7FnVn9Xc1TpluQ1zAwzgPEd0YHjehqFk0lSJjeuYyyH6EbwY5JxiW/Ls1MT27Pi7+y
         hTTGpyZ2zlf7iddiJEzMgOSt7lv0m3tlPmO5xFybEnTybqTfLKoB67Pgg6OEAJrN/TuE
         KR3A==
X-Gm-Message-State: AOAM530gkLMJsm/CquxUuHbqsUDxDMkyuw/7GPtpZsHE2uttBLKTis/O
        pel5MSp6MVYuJsaTd55Tk3E=
X-Google-Smtp-Source: ABdhPJymt7En80dZe3oV3AmeF01oXinFd+vz4l2FwpOdSJenB05fjyQ1B2jwhWUBri8ayNY6K/YUnw==
X-Received: by 2002:a5d:4287:: with SMTP id k7mr7719744wrq.317.1612824836871;
        Mon, 08 Feb 2021 14:53:56 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b2sm11598136wrv.73.2021.02.08.14.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 14:53:55 -0800 (PST)
Date:   Mon, 8 Feb 2021 23:53:54 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RESEND v4 1/6] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YCHBAmFAOv/Joqp5@rocinante>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
 <bba090c3d9d3d90fb2dfe5f2aaa52c155d87958f.1612390291.git.gustavo.pimentel@synopsys.com>
 <YB9EDzI7mSrzXUUB@rocinante>
 <DM5PR12MB18354765D69889F2CD6E4D89DA8F9@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR12MB18354765D69889F2CD6E4D89DA8F9@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Bjorn]

Hi Gustavo,

[...]
> Thanks for your review. I will wait for a couple of days, before sending 
> a new version of this patch series based on your feedback.

Thank you!

There might be one more change, and improvement, to be done as per
Bjorn's feedback, see:

  https://lore.kernel.org/linux-pci/20210208193516.GA406304@bjorn-Precision-5520/

The code in question would be (exceprt from the patch):

[...]
+static int dw_xdata_pcie_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *pid)
+{
+	const struct dw_xdata_pcie_data *pdata = (void *)pid->driver_data;
+	struct dw_xdata *dw;
[...]
+	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
+	if (!dw->rg_region.vaddr)
+		return -ENOMEM;
[...]

Perhaps something like the following would would?

void __iomem * const *iomap_table;

iomap_table = pcim_iomap_table(pdev);
if (!iomap_table)
        return -ENOMEM;

dw->rg_region.vaddr = iomap_table[pdata->rg_bar];
if (!dw->rg_region.vaddr)
	return -ENOMEM;

With sensible error messages added, of course.  What do you think?

Krzysztof
