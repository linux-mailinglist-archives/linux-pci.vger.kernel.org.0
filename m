Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D6D27F12A
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgI3SR2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 14:17:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45420 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 14:17:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id g96so2736403otb.12;
        Wed, 30 Sep 2020 11:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HfocoN8jnNi412P6cV06kFb4hY3gTbW/yUeIlx+erSw=;
        b=G3Jjza3vFXuc9KDdYtZD1lUtrjf70zUvJt3XLfGcnevnYQEWPFhGr/9DgdYRPQwfTO
         YVCDhEQh3jdBdt4sPZLuY0xSM7o9abd5clFHbz9b86Hm/MACPF033h/rylpaCceBX4Cb
         NOEo//gJiBV9YGbxBfGVfxtoxFbSGQV90EiMCDHXYuoJZ/x1QmZ0zQIexYBfUNKCQ6iR
         laz1+7RxfgXSCsscblIXwtVM/DsKjdFruvs0sG8BIzGh59BVg/dgKgFBH6g5jKDyoVkG
         RyhbOp3yYeEs/bNn7wBnc5GKLtFceaFt0qMIVWKlfYn5HB29plQcyMc+hzsYvcT6vaTL
         2p8g==
X-Gm-Message-State: AOAM531bggPCU8+CVKed/mgC9HIgqiXXZZb9B8+mtf4o+9Ra3pH6FhU5
        yd6XZKN0MGg0MiJSRJ9FVw==
X-Google-Smtp-Source: ABdhPJxbK6hoiyKNpMzmoDBLBobDYx879NczLVglVUutqLlDgqalJ+t+rfvvH+C6HortbEhqDFNSjQ==
X-Received: by 2002:a9d:490a:: with SMTP id e10mr2397465otf.325.1601489846902;
        Wed, 30 Sep 2020 11:17:26 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b17sm581935oog.25.2020.09.30.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 11:17:26 -0700 (PDT)
Received: (nullmailer pid 3169634 invoked by uid 1000);
        Wed, 30 Sep 2020 18:17:24 -0000
Date:   Wed, 30 Sep 2020 13:17:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] phy: marvell: comphy: Convert internal SMCC firmware
 return codes to errno
Message-ID: <20200930181724.GA3169568@bogus>
References: <20200902144344.16684-1-pali@kernel.org>
 <20200902144344.16684-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902144344.16684-2-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 02 Sep 2020 16:43:43 +0200, Pali Rohár wrote:
> Driver ->power_on and ->power_off callbacks leaks internal SMCC firmware
> return codes to phy caller. This patch converts SMCC error codes to
> standard linux errno codes. Include file linux/arm-smccc.h already provides
> defines for SMCC error codes, so use them instead of custom driver defines.
> Note that return value is signed 32bit, but stored in unsigned long type
> with zero padding.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 14 +++++++++++---
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 14 +++++++++++---
>  2 files changed, 22 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
