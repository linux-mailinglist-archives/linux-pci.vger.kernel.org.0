Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D6E3829E4
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 12:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbhEQKfz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 06:35:55 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33732 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhEQKfz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 May 2021 06:35:55 -0400
Received: by mail-lj1-f182.google.com with SMTP id o8so6626459ljp.0;
        Mon, 17 May 2021 03:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cISVLFf5r+Q+Y1Ag3U69wbjXa+0XWvrNw3kjHGs/8/o=;
        b=rTAkrulaPJfFAn6p4Q7nCIvijUboE/btfFokWFtDb7VJxNZC9Skxq0PuPcgHaR7Pzv
         NnA0QpIIl8/Ifk7ZMrMwR16+5xsyfpymIDChc8WCyk/17k70t8h4z4/mt6FqTRn6gwCT
         zC3sFybVuBb3bx9/9aBuahjLo5u+5Iv1LM/rZzXhFdefNmgQeYspShxCiX1HGGron4xV
         qs06skxSncQLT5kIfouMtTdjbxadvvFvFEe7g/eXL5o51VgsPdznkR3tZeYJT5mGsnUJ
         iaKy9T5YSCkump+WBGKvctSbphHUJskIASp6R42+HvhokaIJlJP5a18vkfKIMlU0yoGt
         HdcA==
X-Gm-Message-State: AOAM531+WU04R/YefUH1bTKfVDZ1N9BN419GkIQhH9H9rz/W1RLiiPPz
        xVr4mZ8oyvgtbtZ033/zN0o=
X-Google-Smtp-Source: ABdhPJzxk9Ycxex6Fr68yjNoW9ZJzEO6iCuEPjssGTdtjJD7hBY2kMP5Paij/9P7sazHbMl2mmJaWg==
X-Received: by 2002:a05:651c:104e:: with SMTP id x14mr49404014ljm.345.1621247677201;
        Mon, 17 May 2021 03:34:37 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z15sm2864418ljc.84.2021.05.17.03.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:34:36 -0700 (PDT)
Date:   Mon, 17 May 2021 12:34:35 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] PCI: ftpci100: rename macro name collision
Message-ID: <20210517103435.GA179901@rocinante.localdomain>
References: <20210516190014.25664-1-rdunlap@infradead.org>
 <CACRpkdbcN4d2sdCDjqqW7txDm7--_B2MX10CDA6z8FOq4mQ7=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACRpkdbcN4d2sdCDjqqW7txDm7--_B2MX10CDA6z8FOq4mQ7=g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Randy and Linus,

[...]
> > PCI_IOSIZE is defined in mach-loongson64/spaces.h, so change the name
> > of this macro in pci-ftpci100.c.
[...]
> Though I suspect the real solution is to prefix all macros with FTPCI_*?

Agreed, especially since some of the constants and macros in this
driver already prefix various names using "FARADAY_".  We could keep
this pattern and apply this prefix to other things.  There are also
other constants and macros named starting with "PCI_" that could
potentially be renamed too.

Having said that, I actually wonder if some of these constants and
macros are would be something we already have declared (people tend to
often solve the same problems)and could be reused, as per:

  #define PCI_IOSIZE	0x00
  #define PCI_PROT	0x04 /* AHB protection */
  #define PCI_CTRL	0x08 /* PCI control signal */
  #define PCI_SOFTRST	0x10 /* Soft reset counter and response error enable */
  #define PCI_CONFIG	0x28 /* PCI configuration command register */
  #define PCI_DATA	0x2C

Or these:

  #define PCI_CONF_ENABLE	BIT(31)
  #define PCI_CONF_WHERE(r)	((r) & 0xFC)
  #define PCI_CONF_BUS(b)	(((b) & 0xFF) << 16)
  #define PCI_CONF_DEVICE(d)	(((d) & 0x1F) << 11)
  #define PCI_CONF_FUNCTION(f)	(((f) & 0x07) << 8)

Krzysztof
