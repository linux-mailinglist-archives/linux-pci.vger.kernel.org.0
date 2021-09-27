Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7941A2EE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 00:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhI0Wat (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 18:30:49 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:35556 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhI0Wat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 18:30:49 -0400
Received: by mail-pj1-f48.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so313591pjw.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Sep 2021 15:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cwVUxgcxdgVmqAE89IYIm6RY1N3Lvwvc/v3h/JvdnEQ=;
        b=IanBkjprTL5xAaRFDtHhTaGS2AZxrDnehuYm8fpu8PWM5urP60LSCJR5YRwB4F9qeo
         i9y8OgT8HUkw8ABbl/2xPjuWkPfBitrc1CrkeATzrKGaKW7PZ7Kw5yEHX9BHwG7kj2y9
         o71bZODpJ7TLczRevro938D2J5HsHVckOYEck7iC/l19wTCmJwjeywYmHa7kajkxeZcj
         D+FQWoAx9vUNSz3vW4OzjbszDDDhJa98Veic3yMPQv008qs/srH+WQplhFx5Fexi6ciG
         5hwafD9FPWglKgu4gm1ZfdXXAvj609Cb8BbDas43+jdcF9N16GyvlqKsS/XjTTiY0R3c
         XPxQ==
X-Gm-Message-State: AOAM533cHyQmj5mJA7sTLchZqrDUQkFTWfEBSWgrxrmX6vlhDbpLxjya
        5iXkyOaD1fX0/qyPOMzD80Y=
X-Google-Smtp-Source: ABdhPJyNU4gOe/N4Zbscp0KDag6ef73AgXx7ALycrRgQi2/f+cMHp4XW6Dn1AhT2TFdQRY7azBKtQQ==
X-Received: by 2002:a17:90a:190:: with SMTP id 16mr1619388pjc.152.1632781750412;
        Mon, 27 Sep 2021 15:29:10 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j11sm387007pjd.45.2021.09.27.15.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 15:29:09 -0700 (PDT)
Date:   Tue, 28 Sep 2021 00:29:00 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/VPD: Add simple sanity check to pci_vpd_size()
Message-ID: <YVJFrI2PIRkvMich@rocinante>
References: <135abde5-dc5b-826e-e20d-0f53bf32d2dc@gmail.com>
 <20210917135342.GB1518947@rocinante>
 <371af84d-a709-074e-5424-1870eb1c460c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <371af84d-a709-074e-5424-1870eb1c460c@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Heiner,

> > [...]
> >> Instead let's add a simple sanity check on the number of found tags.
> >> A VPD image conforming to the PCI spec can have max. 4 tags:
> >> id string, ro section, rw section, end tag.
> > 
> > It's always nice to check if something is compliant with the specification.
> > 
> > Would you be able to either cite this part of the official specification or
> > mention where to find it?  Like we do in other such changes related to some
> > official standards, mainly for posterity to benefit others that might look
> > at this commit in the future.
> > 
> Right, I should have mentioned that:
> PCI 3.0 I.3.1. VPD Large and Small Resource Data Tags

Very nice!  Do you have plans to send v2 that include this information or
you reckon this is something Bjorn could add when merging if he has the
time, of course.

> > [...]
> >> +		/* We can have max 4 tags: STRING_ID, RO, RW, END */
> >> +		if (++num_tags > 4)
> >> +			goto error;
> > 
> > Do we want to let someone know that their device (or a device they might
> > have in the system) has non-compliant and/or malformed VPD which is why we
> > decided to return an error?  I wonder if this would help with
> > troubleshooting or just simply had some informative value.  So perhaps
> > a warning or debug level message?  What do you think?
> > 
> A message is printed, see code after error label.  We differentiate
> between "hard" and "soft" error. Soft error here means that the VPD EEPROM
> is optional, in such a case it's not an actual error that the VPD reads
> return non-VPD data.

Got it.  Thank you!

I had a look and, does the following:

	pci_info(dev, "invalid VPD tag %#04x (size %zu) at offset %zu%s\n",
		 header[0], size, off, off == 0 ?
		 "; assume missing optional EEPROM" : "");

Still apply to having too many tags?  Would the error make sense?  Forgive
me for asking about this, especially as I am not a VPD expert, and was
simply wondering.

Also, does pci_info() there makes sense?  Not pci_warn() or pci_err(), just
so this message has more appropriate weight and logging level.  What do you
think?

> > Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
