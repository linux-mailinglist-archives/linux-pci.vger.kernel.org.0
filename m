Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF634A43F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 10:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCZJZZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 05:25:25 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:44781 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhCZJZU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 05:25:20 -0400
Received: by mail-lf1-f51.google.com with SMTP id b83so6648401lfd.11;
        Fri, 26 Mar 2021 02:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MWassWFEXaUX1gHbazVX0W/gBRgphn/sg0J1pohK+Y=;
        b=jHmU/CuRW7LQj63Bmjqt00mfbt7VkgwAdCvqcc9QSIIhDhZZ+X+YOVbf9YCZWeVuKq
         0Txm920CqnnHNA62KUMb4q5IvR3btEkeWuPkqOm5kT32uE8I2hGaxH4q3dQi12jL5PJl
         1OK7NdN0eeoFgsdM2yL+0+8s+F1Eq+SB0lfR32QuRxtZBzApPaeTOpZN7E9fVLdUeH01
         ZkRC2aRXNUJYkGEnr2pT+pK4LNy6zTpnf/SvxdMpgAiVyX+AGY6etUX0mfLz1KX3s5fL
         yFXyVDn/z6VI5GcdKg9Ut1o1wcy7+KxlKijejqz2kzhcH/vFOmEKSvt5Bb9pTdXHxdcK
         Op7A==
X-Gm-Message-State: AOAM530Tbar2TLprh88hsmPoDspayLPL1uX8YDmLLvJRBlv6Bgl7ZEDx
        9C1yXZByQRT8iJddpGRjhFLWkQ09Y+rnBA==
X-Google-Smtp-Source: ABdhPJx0nOnsKRf0coi6TFnhNpyOiKPW387JS0XuFm2mL6CdKkaGVnEw37/51utTVM7jAB8mITiW2Q==
X-Received: by 2002:ac2:54ab:: with SMTP id w11mr7771994lfk.260.1616750718849;
        Fri, 26 Mar 2021 02:25:18 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u15sm838275lfl.110.2021.03.26.02.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:25:18 -0700 (PDT)
Date:   Fri, 26 Mar 2021 10:25:17 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Disable D3cold support on Intel XMM7360
Message-ID: <YF2ofVoGlEb07NYm@rocinante>
References: <20210324111316.250576-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210324111316.250576-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thank you for sending the patch over!

[...]
> +static void pci_fixup_no_d3cold(struct pci_dev *pdev)
> +{
> +	pci_info(pdev, "disable D3cold\n");

Not sure how useful this message would generally be?  Unless this is
useful to someone who is doing some troubleshooting, etc.

> +	pci_d3cold_disable(pdev);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7360, pci_fixup_no_d3cold);
[...]

A small suggestion: a brief comment, perhaps even linking to the
Bugzilla, might be a nice touch here, so that people would know why
D3cold is being disabled for XMM7360, etc.

Krzysztof
