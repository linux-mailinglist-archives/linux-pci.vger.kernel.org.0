Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF7944DEA7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 00:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhKKXxq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 18:53:46 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:39781 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhKKXxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 18:53:46 -0500
Received: by mail-pl1-f177.google.com with SMTP id t21so7017018plr.6;
        Thu, 11 Nov 2021 15:50:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qS0CZVkEvy8NrjwRDarW2YyyqB6q3ZZReQXlxj9DPj0=;
        b=sQCEQHtYjKjNsupEof8Bd0IPeTFyXvq4adX8upmMT/yP73PjteCsjP6xnd4jALQ0AN
         b5uEi3+7CU90gic1fhIrYiU2l/NkndcpUKTOeRWVSpeMRQPqWB1JFHbWu3FvUrEmZn8f
         3b0o8y/yx37R7V55qdeXxKpjuzs9mKEdnq0fK46BLBAhSrP4UXDv/xIn0sVZeyb8UxA9
         O0AbRiMP3QA2YQslPY4y4kMBlu39VPWatszwO++dwZsh0iJjB3WGCBO8Pv267RkYi4uF
         cB0Sb8V198wSdCeRnOOJGLiZZGE+0SJ4lVtlImtXHS4HSutE8UlrMCH4+uk5hOFMM1US
         dLUw==
X-Gm-Message-State: AOAM530lpJJcXReqEl7OaDPOVm5KpdVsJWKbAn2RCUrr8hVpVJpyQ24r
        hXwGd5Ronp3W1x0ymlnXYZM=
X-Google-Smtp-Source: ABdhPJxD7vgHOm+CqjTu4Cb7VMMXgmwd7ogt0bcdV5HCmtkwKSO7JKxyoZuGP9UEOQQUth3qc0HZ5w==
X-Received: by 2002:a17:90a:ad47:: with SMTP id w7mr31239452pjv.16.1636674656522;
        Thu, 11 Nov 2021 15:50:56 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d19sm4266356pfl.169.2021.11.11.15.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 15:50:56 -0800 (PST)
Date:   Fri, 12 Nov 2021 00:50:44 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 4/8] PCI/portdrv: Create pcie_is_port_dev() func from
 existing code
Message-ID: <YY2sVNEcVmQinbj8@rocinante>
References: <20211110221456.11977-1-jim2101024@gmail.com>
 <20211110221456.11977-5-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110221456.11977-5-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jim,

[...]
> +bool pcie_is_port_dev(struct pci_dev *dev)
> +{
> +	int type;
> +
> +	if (!dev)
> +		return false;
> +
> +	type = pci_pcie_type(dev);
> +
> +	return pci_is_pcie(dev) &&
> +		((type == PCI_EXP_TYPE_ROOT_PORT) ||
> +		 (type == PCI_EXP_TYPE_UPSTREAM) ||
> +		 (type == PCI_EXP_TYPE_DOWNSTREAM) ||
> +		 (type == PCI_EXP_TYPE_RC_EC));
> +}
> +EXPORT_SYMBOL_GPL(pcie_is_port_dev);

It would be really nice to document what the above function does (not that
some of the logic has been extracted from other function).  You know, for
the future generations of kernel hackers.

	Krzysztof
