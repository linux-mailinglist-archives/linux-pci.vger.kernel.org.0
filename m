Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD95E156743
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 20:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgBHTHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 14:07:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43409 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgBHTHj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 14:07:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so2733876ljm.10
        for <linux-pci@vger.kernel.org>; Sat, 08 Feb 2020 11:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+vjXU2SW2HOdfOFCkX7livwJmowb74J31opeMZWUCA=;
        b=w0JdVEgTe4SS+T8Svfog6mLAmWZXFIwgC71xGQqk2YbPV+MgtSYLwJCUnqbuKx8+Uh
         u50q+ll5mqnMS7iOwjH6yhEL/+AOxKXpVOH4bxJadba4hQQkudbbwW2yJbbVJ1dED4gK
         wrt0X/U8D0gjOIz71tSYEotpqYiQROKSBzbW38Nq6uMuBT2TNTaKFuevQjHPf28VsNhM
         d76Ue5OuvTSg/91VKorHegpXZpdC8A/4USXNauaeNukjXZXGDmEN/fVCi0/bnOUB/UKo
         Q8WtQgNlSbo2zvGBKClFIRFrKxMbg1VPI3r10Bf5XYITJw1QX3ls88Y9F7c82MgDDm67
         KtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=q+vjXU2SW2HOdfOFCkX7livwJmowb74J31opeMZWUCA=;
        b=NCppvYDSbjKx7dqj77jnzK37b6wU2oiPyV2UUfQJ3VCqk1pagE2qKJx1BsIpO/Nzrr
         6lqr2jFmVpSlfMxWj3UT+ardiCky6Rd54fiN+wKZOquQfwizKTz8/zF+XbxP+9eN30nj
         JCEisxOQZa1yC4ar5LZ9tFDmoZC2mjMxGsMoD75Lm7audLix20AnXxzP5Kj4/JSaMjxm
         wEkmzZizW523kcNrVe5ewZF6S0ykXOJySJ8kxdNoFQKl3oz8trgYC7v5s4C9EKHp0VCv
         +sVof6I1Gf7BlrobiN5oXGMlW/8lIcw7P5JGY/z4RJHRMw6dlHT80IWnGU4V0YJ3o6Z1
         x8Kg==
X-Gm-Message-State: APjAAAV/K87VZ/BMfY9izGswzQiGmN+jqk7W2aoxUmvGmPfLYPdXjnbH
        4TIMDWiohDJ9a1TvMTgYTc+u+Q==
X-Google-Smtp-Source: APXvYqw+hv9rxpIg4ETFyGzRDGxPLYofUNYjHEUqHuRFb3fygBzmWxL7+wK/VYmQ6OV/4Fn5/LcxYw==
X-Received: by 2002:a2e:9696:: with SMTP id q22mr3229986lji.54.1581188856412;
        Sat, 08 Feb 2020 11:07:36 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:48a2:c7a4:1f8a:70c9:2c66:3e73])
        by smtp.gmail.com with ESMTPSA id w9sm3508790ljh.106.2020.02.08.11.07.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 11:07:35 -0800 (PST)
Subject: Re: [PATCH v4 2/6] PCI: rcar: Fix calculating mask for PCIEPAMR
 register
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200208183641.6674-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <374e26ca-cd3d-fd12-edad-5f24622b9d3d@cogentembedded.com>
Date:   Sat, 8 Feb 2020 22:07:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20200208183641.6674-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 02/08/2020 09:36 PM, Lad Prabhakar wrote:

> The mask value was calculated incorrectly for PCIEPAMR register if the
> size was less the 128bytes, this patch fixes the above by adding a check

   Less than, perhaps?

> on size.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
[...]

MBR, Sergei
