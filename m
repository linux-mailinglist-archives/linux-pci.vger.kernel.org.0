Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEB03BC3EB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 00:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhGEWhc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 18:37:32 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:34512 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhGEWhc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 18:37:32 -0400
Received: by mail-lf1-f48.google.com with SMTP id f30so34861921lfj.1;
        Mon, 05 Jul 2021 15:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j1caghW4kfrgj6lvZ4VhPk/s9QzfestewBqrhQF3bF8=;
        b=Msm1CQ0HCynsSHhhm1t53dC5WQ26lqrKfg0fezu4yXUypZFvRgsEYidhgx0lGrbNGf
         /f+88sKNmoA1558mOHUKUSbXQY0RHsIRzGqccFZQSUWspVykP8C+SqmZbhTZLiK0nauA
         eNiDkAXl5tIHLonE68JTuVufgcHDxg1qEv32GROskNuo1TDxS6OhvbnQNl9l5LFfDgzf
         mOSZE7bs/3idyV5gCoXisM/VNj75VQPdVdOxclMJ1kVk8NhhN2F1Gk6JOpo82RLMJYzf
         ZI5ut5Ji8zM4d1iSc8H/9KSMmcv8UvNqEuyQJLjSOondXla5y7lTvPquwjJ9w6lU79xL
         RGeQ==
X-Gm-Message-State: AOAM533Ax3+zw/c8HKTYU/hO5C/y9AhN7/8IeO61DITc2AVDIJx8We/n
        I/fNsWeYuQr10Sm3aE+Tc7s=
X-Google-Smtp-Source: ABdhPJwWk9FwUUI2LNR78S2WGXbwmY6zTo3fY3eH4MP9Eq16Gp6VELdkkizH/gvghaG/sDqFjkIzsQ==
X-Received: by 2002:ac2:5619:: with SMTP id v25mr11738645lfd.434.1625524492430;
        Mon, 05 Jul 2021 15:34:52 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id f2sm1506566ljk.79.2021.07.05.15.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 15:34:51 -0700 (PDT)
Date:   Tue, 6 Jul 2021 00:34:50 +0200
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Art Nikpal <email2tema@gmail.com>
Cc:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Artem Lapkin <art@khadas.com>,
        Nick Xie <nick@khadas.com>, Gouwa Wang <gouwa@khadas.com>,
        chenhuacai@gmail.com
Subject: Re: Re: [PATCH 0/4] PCI: replace dublicated MRRS limit quirks
Message-ID: <20210705223450.GB142312@rocinante>
References: <20210701154634.GA60743@bjorn-Precision-5520>
 <67a9e1fa.81a9.17a64c8e7f7.Coremail.chenhuacai@loongson.cn>
 <CAKaHn9KxRrBsn4b9fSO1eDzM3XdV2GzfwVX+cGw9uS_eKg75dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKaHn9KxRrBsn4b9fSO1eDzM3XdV2GzfwVX+cGw9uS_eKg75dw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Art,

[...]
> If no one has any objection, I can try to remake it again.

I can't speak for everyone, of course, but I am sure that nobody would
object if you decide to work on v2, so that a proper fix can be applied,
and issues fixed long term.

Thank you for working on this!  Much appreciated!

	Krzysztof
