Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA84382B2
	for <lists+linux-pci@lfdr.de>; Sat, 23 Oct 2021 11:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJWJ4B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Oct 2021 05:56:01 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:42521 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhJWJ4B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Oct 2021 05:56:01 -0400
Received: by mail-ed1-f45.google.com with SMTP id w15so522629edc.9;
        Sat, 23 Oct 2021 02:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O9Rb9NtokiMkDgVECkBf3jx/VCvIk8TeI7+YpJW1Fwo=;
        b=FSKSo5jQIe3nTYkJMxHapKiJMl31rsVIHYH4SAiL7vAM+PHEq7vlCRTfrEoS4bJ1Fr
         Zcjj1IcLTYaWwJXf//nxVRsiQ1ulNOhdW61GmQRYQy64tds0MEkI3BKlToJa4gGAhKqW
         yQEXHkzHHPCwfQtj2aZG6JIDnbBMaaLKm1RhTEG+yjieVY98o2iLX7xCkziBs/PP8FaN
         BDj8/YMlfpHugk5ThV7xGXVaYE2ToiQ+ewpVm5otcBZUZCbKa5cMP+RS2V8Xzkgdjudf
         AiRSk8z8i0vJxXWxisGVXsh2bnF1EGr46WePextHmMz+/gCJ7qK0QrFaCbf8QAMb8QZI
         rBcA==
X-Gm-Message-State: AOAM533S7U8J8ZVGz0UaxFn2CwLirjVQ+h0dqrP7cvwRqP+y52b9sJo9
        BJn3b/ZDn909/GbK80eezQk=
X-Google-Smtp-Source: ABdhPJwVIXLBQ0vc4x07Rr+ZeyW3N4/87ZMumw1JvUUOJuIoVhZhvZe7EUOpXbLHg5Y5aXiOhsy4bg==
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr7616596edc.323.1634982821528;
        Sat, 23 Oct 2021 02:53:41 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f9sm283635edt.7.2021.10.23.02.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 02:53:40 -0700 (PDT)
Date:   Sat, 23 Oct 2021 11:53:39 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Message-ID: <YXPbozFVw25gVGvW@rocinante>
References: <20211015184943.GA2139079@bhelgaas>
 <20211015185141.GA2139462@bhelgaas>
 <AS8PR04MB86767ADAB5021E1C320094148CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <AS8PR04MB867697359A6D51903D0098308C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS8PR04MB867697359A6D51903D0098308C809@AS8PR04MB8676.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

[...]
> > > > > -	default:
> > > > > -		break;
> > >
> > > While you're at it, this "default: break;" thing is pointless.
> > > Normally it's better to just *move* something without changing it at
> > > all, but this is such a simple thing I think you could drop this at
> > > the same time as the move.
> > >
> > [Richard Zhu] Okay, got that. Would remove the "default:break" later. Thanks.
> [Richard Zhu] I figure out that the default:break is required by IMX6Q/IMX6QP.
>  So I just don't drop them in v3 patch-set.

I hope you don't mind me asking, but how is an empty default case in the
switch statement helping IMX6Q and IMX6QP?  What does it achieve for these
two controllers specifically?

	Krzysztof
