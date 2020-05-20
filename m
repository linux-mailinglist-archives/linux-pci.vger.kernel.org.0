Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4790C1DC246
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 00:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgETWlG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 18:41:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33488 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgETWlG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 18:41:06 -0400
Received: by mail-io1-f65.google.com with SMTP id k18so5251997ion.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 15:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rdpm/mcZt7uA7TiLroApn2m8wUuCfNFwat149/iug0w=;
        b=Js0h1Nww/fgEj1+7q6CBCGaWRkpOGTgpo+Msx8e0kR1iK+ZU0VxxI1TkWr0YFuyj9I
         u6XhCqvNd1wbZ4RoTcmPleKy6qFms72if1bTDZEOonwyYM/HATbvkGPBTzGtwksRjBnE
         K8zufZkKvATP2hLnj0oAc0rx5HtQuIbcefbTq4AeI40BuPiD2ZMIjtLwOEwpBAZX4z1J
         0bGn/7mG6adDX4QuYZ3AhgfXomWk3+x9FB59xtPntlxrZLunZMzWfYszQDmq3uTVhoQH
         kLNKnxgwFCH1TowrYBrNMztxlbcyuoCus0hZoEKBRo07SB1/rZjNmbFyYyLYLP+F2f+q
         TkbQ==
X-Gm-Message-State: AOAM532lHyGp/T90j30T0T/7X1kfqs9SFzV6RAJ5YvjTF2jnWZD7Kqmk
        Ue7Xf+/CpPzIoX6yvEpCgw+DjlI=
X-Google-Smtp-Source: ABdhPJwoL+Z+CjGOuOC3D3RUsv0dr2BjzLPpQ6++fP4L9IierooFgeW6iX+rh/XvyqtBJ2pKOYgUkA==
X-Received: by 2002:a05:6638:68f:: with SMTP id i15mr1337491jab.136.1590014465272;
        Wed, 20 May 2020 15:41:05 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s22sm2122851ilk.50.2020.05.20.15.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:41:04 -0700 (PDT)
Received: (nullmailer pid 736726 invoked by uid 1000);
        Wed, 20 May 2020 22:41:03 -0000
Date:   Wed, 20 May 2020 16:41:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: pci-bridge-emul: Eliminate the 'reserved'
 member
Message-ID: <20200520224103.GA736673@bogus>
References: <20200511162117.6674-1-jonathan.derrick@intel.com>
 <20200511162117.6674-5-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511162117.6674-5-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 May 2020 12:21:17 -0400, Jon Derrick wrote:
> Per PCIe 5.0 r1.0, Terms and Acronyms, Page 80:
> 
>   Reserved register fields must be read only and must return 0 (all 0's
>   for multi-bit fields) when read. Reserved encodings for register and
>   packet fields must not be used. Any implementation dependence on a
>   Reserved field value or encoding will result in an implementation that
>   is not PCI Express-compliant.
> 
> This patch ensures reads will return 0 for any bit not in the Read-Only,
> Read-Write, or Write-1-to-Clear bitmasks.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/pci-bridge-emul.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
