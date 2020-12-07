Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A308D2D1BD5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 22:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgLGVOV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 16:14:21 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36228 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgLGVOV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 16:14:21 -0500
Received: by mail-oi1-f194.google.com with SMTP id x16so17081877oic.3;
        Mon, 07 Dec 2020 13:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wSSUTQZg6bgD+NFU+dlyoaBo/UNi5gEZyvnAHdAYmoI=;
        b=RN9JS3E7E9gcR0KUJzJ56alonCOF9zuUJoeFP0W4/pdjrULcIPkwLhTlfTjDnag/0F
         mbe6F6R7hMJQlDRFjZ5qlGsBglNEOaJikveEKE5SAR+C4faDn/ApwbwKDiW1/OpFp3CR
         42YTpy8CzGEbwSYzY6tfs3QOyXhjJ5F8UWbZF0F6MBJLT9pgK43eejPZqQw74e9f7Um9
         i6wgRshxbXVzcM38pNHf9L7fx5Z1UQQg8nx7lxrL11B2+b+VUniktW2V1w/kwre+velW
         MYPUVhwB6zzqizvMTq8EWPX0y+JgFBMHtlWKe7Z64VRVPmi2RsA8VlZdFXqLhN+mN/ym
         dbCg==
X-Gm-Message-State: AOAM530EPfaaICi1YIGSjeY/E/wJqjduIRXhqGcdQeBlOXgO2zcCLDWq
        q8SdzJ+ZE4t0lHsrwcp5BQ==
X-Google-Smtp-Source: ABdhPJwxEb2r9vTvghtzHd8K3uHSFXi9O1760V/OHmnDBVyD9HJ35YFbgajx/vD/9xQJIohC18waoQ==
X-Received: by 2002:aca:3192:: with SMTP id x140mr558323oix.172.1607375620156;
        Mon, 07 Dec 2020 13:13:40 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t186sm3224633oif.1.2020.12.07.13.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 13:13:38 -0800 (PST)
Received: (nullmailer pid 835084 invoked by uid 1000);
        Mon, 07 Dec 2020 21:13:37 -0000
Date:   Mon, 7 Dec 2020 15:13:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-rockchip@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: rockchip: Add FriendlyARM
 NanoPi M4B
Message-ID: <20201207211337.GA835025@robh.at.kernel.org>
References: <20201118071724.4866-1-wens@kernel.org>
 <20201118071724.4866-3-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118071724.4866-3-wens@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 18 Nov 2020 15:17:22 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The NanoPi M4B is a minor revision of the original M4.
> 
> The differences against the original Nanopi M4 that are common with the
> other M4V2 revision include:
> 
>   - microphone header removed
>   - power button added
>   - recovery button added
> 
> Additional changes specific to the M4B:
> 
>   - USB 3.0 hub removed; board now has 2x USB 3.0 type-A ports and 2x
>     USB 2.0 ports
>   - ADB toggle switch added; this changes the top USB 3.0 host port to
>     a peripheral port
>   - Type-C port no longer supports data or PD
>   - WiFi/Bluetooth combo chip switched to AP6256, which supports BT 5.0
>     but only 1T1R (down from 2T2R) for WiFi
> 
> Add a compatible string for the new board revision.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
