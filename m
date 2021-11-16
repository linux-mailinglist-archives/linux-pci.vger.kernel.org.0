Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4D453A4C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 20:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbhKPTnv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 14:43:51 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:36404 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbhKPTnu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 14:43:50 -0500
Received: by mail-pf1-f170.google.com with SMTP id n26so376161pff.3;
        Tue, 16 Nov 2021 11:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JO81Agbe5WodbQoYIQdT48bZEHg2H9k1d9p6sxf0m3Q=;
        b=OZGjM31mk5dAKLZBq+u++t/BndM9x6hdWGzugIt6gCbFu7SY9pgHxfCV0gD8P/N0Yl
         W4vRPQXkJVkxIz2Q+MRd5AX1exkN3wtr5iaqOhcFVpRJ06tXIYBD5o2v3anWPGqaVA5r
         +HaQddYPpx4JBzdV5aHhuYuI+afKcMmIWVOSlqbmubv1czLbMtlvnBkuOTrnUPk6lTn0
         lvTWtSikKac1Y9vuxzf+rnAVvFGMPuJHhgC1E8N6/8gtfRkHKh39uVR2BT+GOPfBSaRS
         HCMQBTCT1VUPjChpLAOT9EpUKmTATtO8aWqdy9NM7rIG9eqEDx+4PdvpJB41V4QrYmte
         /slg==
X-Gm-Message-State: AOAM532DwMK4sH1sCItTVo/S7aLmcKqkt2aHeWNVYZrhwXFURaYhKmp0
        mLkr0sD0SGJuYY6vnCLQ9GLQA34WXGKRY/xi
X-Google-Smtp-Source: ABdhPJxytwHi1yhH1LA3KhKBGuokPekTGZp76tfLHybYBU0hTJEcef+vxKctSCD27K8Fak7CBSZSSw==
X-Received: by 2002:a05:6a00:1822:b0:49f:c55b:6235 with SMTP id y34-20020a056a00182200b0049fc55b6235mr1594968pfa.66.1637091653156;
        Tue, 16 Nov 2021 11:40:53 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o134sm19183817pfg.1.2021.11.16.11.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 11:40:52 -0800 (PST)
Date:   Tue, 16 Nov 2021 20:40:43 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     sean.v.kelley@linux.intel.com, bugzilla-daemon@bugzilla.kernel.org,
        linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
        Sean V Kelley <seanvk.dev@oregontracks.org>
Subject: Re: [Bug 214789] ehci-hcd.c ISR
Message-ID: <YZQJO193uIsM86en@rocinante>
References: <bug-214789-208809@https.bugzilla.kernel.org/>
 <bug-214789-208809-L7vPEsR09B@https.bugzilla.kernel.org/>
 <20211105193942.GA1601081@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211105193942.GA1601081@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Sean using his other e-mail address]

Hi Alan,

> > https://bugzilla.kernel.org/show_bug.cgi?id=214789
> > 
> > --- Comment #22 from Scott Arnold (scott.c.arnold@nasa.gov) ---
> > Hello,
> > This caused problem:
> > https://patchwork.kernel.org/project/linux-pci/patch/20200214213313.66622-2-sean.v.kelley@linux.intel.com/
> > Scott
> 
> This is commit b88bf6c3b6ff ("PCI: Add boot interrupt quirk mechanism 
> for Xeon chipsets").
> 
> Sean and linux-pci readers, please take a look at this bug report 
> (Bugzilla #214789).

Sean might not have been able to see this message, as he is no longer
working for Intel and his old e-mail would bounce.

I am added Sean using a different one I've found, perhaps it would work.

	Krzysztof
