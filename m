Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C31B279460
	for <lists+linux-pci@lfdr.de>; Sat, 26 Sep 2020 00:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgIYWxc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 18:53:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42111 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIYWxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 18:53:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id b12so4513550lfp.9
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 15:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LF6FFyiiTVGdhPp8t/6kz2CvWO926WjsFTWyUjM6nM4=;
        b=P64I6pqchdGlG5M3QDwNZv2sFgFwcQY94FM4C9AVebC+EWYLkldNUIkdMPKJoC6iWQ
         Evcv1RPgPVGccEpsHDpaZxzIBuv0OtwsBYQA0C1U3xTQKXwq7vNhPeM0J19AlheXmvNh
         eI/LOtFgJt5TSmyCCMVLmEv1Xf2wyPYZSTztR4OJU6KZoXGyj9q0gqRgBljG2Vo7bqbI
         Cv01Whuaoe45wT6OCkAVXc2l5oacdYnQ7QKcfVZIoM+t2c44Zs9NzahRV1ea0y7eZW5+
         ZGz3RJtg69t68JTj4IdWUrRjNfl2ts2lkecV/1Tl1wnBu6rxiRmKzJabLvhF5nwWRozB
         48Mg==
X-Gm-Message-State: AOAM533T+djFptRKsdwCiIeuid0wHoV2W0FvGYHDl9jF53JPxlW2PV4G
        JmOSJcd/krbOgEtg85bgCkg=
X-Google-Smtp-Source: ABdhPJxa7VlqIS3RCO2h08ucFjkprMKOKMpI4hL5z45tTmLdAburLaBaTYmX0k27znoVsV0CNYu9og==
X-Received: by 2002:a19:8c46:: with SMTP id i6mr316447lfj.55.1601074410645;
        Fri, 25 Sep 2020 15:53:30 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q17sm345085lfn.145.2020.09.25.15.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 15:53:30 -0700 (PDT)
Date:   Sat, 26 Sep 2020 00:53:29 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix comparison to bool warning in pci.c
Message-ID: <20200925225329.GA91865@rocinante>
References: <20200925224555.1752460-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925224555.1752460-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

This is a trivial patch and I remember you wanted to rename the "decode"
variable to something more meaningful, so I had a look at the
following:

  http://lkml.iu.edu/hypermail/linux/kernel/0908.1/00875.html
  http://lkml.iu.edu/hypermail/linux/kernel/0507.1/1942.html

I also had a look at the "IEEE Std 1275-1994, Standard for Boot
(Initialization Configuration) Firmware, Revision 2.1", but I am still
unsure to what would be a better name for this variable.

Krzysztof
