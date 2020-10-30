Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B952A0DAF
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 19:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgJ3SoJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 14:44:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38640 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3SoJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Oct 2020 14:44:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id b2so6450709ots.5;
        Fri, 30 Oct 2020 11:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gcNHJHCau2pOQDpyrZFfl1xJmZDsePWMpoESjYncX1c=;
        b=djzc+nyU1mUonI5WezInvuY4FHaTWxjSZR3tQm7nRzG/EhiHq5HlRS5cnpT7Kp2rD3
         8VZyXTwGnA8TBkyA/HUKqfj5BjcL+iHKquHAq6+1lvS515gR+2I4kdM7S0j7Qr0pP/+x
         w8ggTGfOFTUCIUGW4fquCI2t5+KsCWrWOiEqBtP8BYE/ICTveVXnxe0OmIIg1lHl+Sc4
         HnociNBzCir2cws8G5T2I6+blFp5eh9xeJNE75QkwY2Kfy50XAwzD+X6DGLNN+lt0ZFN
         QiATuXrpvTehRqadUpmztVT/yCGDSgcj+smD41Y37jfY+CSQTrVD9iWc+XI/vfpLiY8W
         tNpA==
X-Gm-Message-State: AOAM531pAlRrwB9jSh9g3YJMCedDbnyMqBXB5n19xXdF0Zn63/riyrIo
        kmJkJOZlHDiHrrZM+u12aw==
X-Google-Smtp-Source: ABdhPJzvm7F7vBRH4cH6t3hxs9pt9tO7//v63JS74luelUUJOxBLVqB87resXg6syLdyeUlPHUUS0w==
X-Received: by 2002:a9d:3b4:: with SMTP id f49mr1313853otf.188.1604083448041;
        Fri, 30 Oct 2020 11:44:08 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z8sm1470690otm.45.2020.10.30.11.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 11:44:07 -0700 (PDT)
Received: (nullmailer pid 4127461 invoked by uid 1000);
        Fri, 30 Oct 2020 18:44:06 -0000
Date:   Fri, 30 Oct 2020 13:44:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: Fix 32-bit overflow with CONFIG_ARM_LPAE=n
Message-ID: <20201030184406.GA4125298@bogus>
References: <20201026152755.3738293-1-geert+renesas@glider.be>
 <20201027075551.GB22487@lst.de>
 <20201029155918.GA23872@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029155918.GA23872@lst.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 29, 2020 at 04:59:18PM +0100, Christoph Hellwig wrote:
> On Tue, Oct 27, 2020 at 08:55:51AM +0100, Christoph Hellwig wrote:
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > 
> > Rob and Frank: do you want to take this through the OF tree, or should
> > I queue it up in the dma-mapping tree that caused the problem?
> 
> I've picked this up in the dma-mapping tree so that we don't miss
> rc2.

Thanks.

Rob
