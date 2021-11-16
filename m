Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B6D4537D6
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 17:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhKPQm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 11:42:59 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33624 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhKPQm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Nov 2021 11:42:59 -0500
Received: by mail-pl1-f179.google.com with SMTP id y7so18030887plp.0;
        Tue, 16 Nov 2021 08:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=piaXFTBaC2+rpiS9NbodLteQrworeZAeegtjVggyKWc=;
        b=B9Xs5aDFFrWR9WJ77seB/hb1rovDBRWwdNYg5Cm1i16xq4L4CqiKE36r31HOwibsu4
         6NFkFesdWBu3nw9Sxu9xwrhmpuzbMv1XmJsEeOYHNZHzWNaDry3c9+sQ+9V4oo8QRzoF
         10WUF/bRV63qEHzBNF1IPdfW5X2G1joLjGqEWbZgVW+yz6E8wUhvlAud3JM//N1tHAAB
         d9Qgjtl3d/3TDX98FuOxnWuoO4HzzVNhRpomER7t50bdz5yXeFGvaAtYCG+PfZr4+5qw
         xAR/c1wlSND/vzHLaVXc0a1f/Y1haboLaLSwDBNx1VZ2J7WAVgJcIi/5JyRkhyhFFzre
         iG/A==
X-Gm-Message-State: AOAM532dteRqRsyC3QsPCZNpBXqnK5U0VR+kvmilU+8WwKCGodKYmvAR
        Mk2BmPtZhcbPiwzBud75EDyo2jm5BqsBMeJR
X-Google-Smtp-Source: ABdhPJzHQVDgKgk/q6/SL1BPAwHHykK3FrDm7hbVL6c4dElYDdfS2v8PQKlegbZL3RGLj3p/JzT3RA==
X-Received: by 2002:a17:90a:1bc5:: with SMTP id r5mr455835pjr.90.1637080801871;
        Tue, 16 Nov 2021 08:40:01 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y28sm19750558pfa.208.2021.11.16.08.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 08:40:01 -0800 (PST)
Date:   Tue, 16 Nov 2021 17:39:53 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Tom Li <tomli@tomli.me>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add func1 DMA quirk for Marvell 88SE9125 SATA
 controller
Message-ID: <YZPe2XdAYS6zrzxa@rocinante>
References: <YZPA+gSsGWI6+xBP@work>
 <YZPTIllU1KKPviHU@rocinante>
 <YZPYVK9UbNXLcks2@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZPYVK9UbNXLcks2@work>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> On Tue, Nov 16, 2021 at 04:49:54PM +0100, Krzysztof Wilczyński wrote:
> > > Reported-by: sbingner <sam@bingner.com>
> > > Tested-by: sbingner <sam@bingner.com>
> > 
> > Both of these tags would require a proper full name, if possible, rather
> > than a name that is abbreviated and/or a username.
> > 
> > Reviewed-by: Krzysztof Wilczyński <kw@liunx.com>
> > 
> > 	Krzysztof
> 
> No problem, I'll send a revision to correct the tags immediately.

No worries!  Thank you!

	Krzysztof
