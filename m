Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B4524C24E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgHTPgq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 11:36:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729091AbgHTPgo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 11:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597937802;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoZ5OGb6TmDVGND9bPZ/+clJ+2p6aDqeJH5F5modhrM=;
        b=DBY9xfWfIyQIXlUKWn8Dwv3ihZmFzTa8dE6/+hZMXrTekcTo4kS5Qkt4QnPESz2Q2YN8+x
        ia6vHALaK/g2B35OBjBzfESNVsiiePG+zw0hYVtwms4D5bsuM0mSWiFkriAYPMsMYVh7Yo
        Rm+pM/cFXfmAEmbNFc/aNuBJIcezo4o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-kquLe1yYM1ulT6Vp_mrbpA-1; Thu, 20 Aug 2020 11:36:41 -0400
X-MC-Unique: kquLe1yYM1ulT6Vp_mrbpA-1
Received: by mail-qt1-f200.google.com with SMTP id r24so1819701qtu.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2020 08:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=EoZ5OGb6TmDVGND9bPZ/+clJ+2p6aDqeJH5F5modhrM=;
        b=UIKUZ/LPsotLOrw1v0H1WdSp2gLNKJu0HsWGEwl4N/AQEc7PnDlmigMc59DTdxyIsy
         OaJxBq7dGSTBa94jM/i0N1vXGLg3kpybAmh/wr1LxzRpY7OT/LWpCnhz5nQMDsyQZ8bb
         mipCMcBS9sqbEi/haSMPRL78zS6L87QZOeU8dzH/ZJ5aEsu83Y6AoSKr7QH6zlKV6yFU
         hTI4izHFtIvzPhL7AbYW7/a9exkvq6zstEasKYy7XOahS2UaHAtFzkbrD4D4fk8ea9cm
         ZiFD1DhQs9QC6tPi0wnHRb+0xYZKQdS1xVDfS/OLqBFqOlYtoYEGiViWO2N0n4Yec8aR
         NI0g==
X-Gm-Message-State: AOAM530IQsSDEw1WxoJrThQqdFvEmBke+HPQQ930ldJDtTnUh4bMn6Y8
        b7gTwaZWvrj9F+jvWvBomVvzb7+FydZAtk1dNgufcnmQ3062wMwKQQHgWt2+2HxFepmhuA9pnyO
        3tWduNWv2cA7Eqd5iAjYQ
X-Received: by 2002:a37:a756:: with SMTP id q83mr3148646qke.328.1597937800624;
        Thu, 20 Aug 2020 08:36:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4pYlM2PaJuPvbSgqi4EWNKR0qdBZh4Nkva/XSelUmqXUMl+z+DfwEspVBCF2KiIlan4nOGA==
X-Received: by 2002:a37:a756:: with SMTP id q83mr3148627qke.328.1597937800383;
        Thu, 20 Aug 2020 08:36:40 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id j61sm3159421qtd.52.2020.08.20.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:36:38 -0700 (PDT)
Message-ID: <825a566040de2eedc81350cc914dd38dcc3ba4ff.camel@redhat.com>
Subject: Re: [PATCH] PCI/PM: Assume ports without DLL Link Active train
 links in 100 ms
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org
Date:   Thu, 20 Aug 2020 11:36:37 -0400
In-Reply-To: <20200820081314.l25cjoehbnvbjbrk@wunner.de>
References: <20200819130625.12778-1-mika.westerberg@linux.intel.com>
         <20200820081314.l25cjoehbnvbjbrk@wunner.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2020-08-20 at 10:13 +0200, Lukas Wunner wrote:
> On Wed, Aug 19, 2020 at 04:06:25PM +0300, Mika Westerberg wrote:
> > Sec 7.5.3.6 requires such Ports to support DLL Link Active reporting, but
> > at least the Intel JHL6240 Thunderbolt 3 Bridge [8086:15c0] and the Intel
> > JHL7540 Thunderbolt 3 Bridge [8086:15ea] do not.
> [...]
> > +	 * Also do the same for devices that have power management disabled
> > +	 * by their driver and are completely power managed through the
> > +	 * root port power resource instead. This is a special case for
> > +	 * nouveau.
> >  	 */
> > -	if (!pci_is_pcie(dev)) {
> > +	if (!pci_is_pcie(dev) || !child->pm_cap) {
> 
> It sounds like the above-mentioned Thunderbolt controllers are broken,
> not the Nvidia cards, so to me (as an outside observer) it would seem
> more logical that a quirk for the former is needed.  The code comment
> suggests that nouveau somehow has a problem, but that doesn't seem to
> be the case (IIUC).  Also, it's a little ugly to have references to
> specific drivers in PCI core code.
> 
> Maybe this can be fixed with quirks for the Thunderbolt controllers
> which set a flag, and that flag causes the 1000 msec wait to be skipped?
Sorry, some stuff came up yesterday so I didn't get the time to go through my
laptops and test them. I do agree with this though - I'd be worried as well that
nouveau might not be the only driver out there that needs this kind of delay

> 
> Thanks,
> 
> Lukas
> 
-- 
Sincerely,
      Lyude Paul (she/her)
      Software Engineer at Red Hat

