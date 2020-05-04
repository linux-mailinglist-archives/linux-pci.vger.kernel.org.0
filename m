Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA4C1C390C
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 14:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgEDMOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDMOE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 08:14:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC69C061A0E
        for <linux-pci@vger.kernel.org>; Mon,  4 May 2020 05:14:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g185so2686863qke.7
        for <linux-pci@vger.kernel.org>; Mon, 04 May 2020 05:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uYct+1EXK4RvBhS2R9oCZJOA6YnnY92fxMdH3FTHSR4=;
        b=nG7On+yMwtfGBMG3EEnGP/Eyr+dDKC4jICpKbPO6K4fszentgI/sW7dpsCMmC3kiqN
         r05PiNpFvfalngk5g8x2kENDR3bKi+zfFry4JRXeKkoS3rM3hNXK/XEdpT8Eq/owHSGW
         UdGPVNu1ZZE1RFEa4aePGP7JUhSU9acIvXIAgsAUBkHPimnV3tZu8BatePbjTXLAgV7+
         9j2xKqJiFFEFoCV0uizdmuOa8BXz0tOnGSMScdbrYZl1Tgqm2W/ItGaqMvd7WKHjuPUD
         CVJsX/sNmyL9+anfWB63V5O4sThGrMWEzqEkdprm3ZBcuTYZytOlWIPSHHZERyGUDr5J
         kOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uYct+1EXK4RvBhS2R9oCZJOA6YnnY92fxMdH3FTHSR4=;
        b=VOkzoCM2PTggmAhpbz5jZdidBHoJ18GKfCHE78zdq1OKGiXnVm1qYawuO6/WQ2SQm+
         Z2MzlloKEbl/7cU2dsqLOD1gD1Mtp7UFXgA6C29lHBPuLmBnxPEDWihGMe7204SxmDJa
         INFCX5+B9Rp/l/NLU3fv9tf994LRhyV5303jocbq03Z1PgOCG5XjZI0Z83/5cabhGk7u
         0G0OrOgf1GTTB48O81tNq8JxUHT1nPMco+9JUohBmyvZknTCJs3NL8yTSwq7g7q7V4qN
         138SnnjxTzrAM5J4he0vvKxghi+EAXH6pOx+opcVyG1nW45eqoalm7OrZOIJqo2Mnln2
         ekvQ==
X-Gm-Message-State: AGi0PuZushjjWVwe/jglzfjFQFc+XVI5E3L9Kmhd8wc7Tv1uHQhXR153
        G/qMGuig9vEtM1V1QCTOrlqGCA==
X-Google-Smtp-Source: APiQypJo409ZJxzf2nxC+vnBmVCvb7bUK735uBejgyjN4EXp0iDnDYCtO3gUOEBm4tnsvWXbjqQYtA==
X-Received: by 2002:a37:5941:: with SMTP id n62mr15543383qkb.419.1588594442936;
        Mon, 04 May 2020 05:14:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a139sm5077890qkg.107.2020.05.04.05.14.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 05:14:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jVZyz-0005Zd-K8; Mon, 04 May 2020 09:14:01 -0300
Date:   Mon, 4 May 2020 09:14:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Dey, Megha" <megha.dey@linux.intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, vkoul@kernel.org,
        maz@kernel.org, bhelgaas@google.com, rafael@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, hpa@zytor.com,
        alex.williamson@redhat.com, jacob.jun.pan@intel.com,
        ashok.raj@intel.com, yi.l.liu@intel.com, baolu.lu@intel.com,
        kevin.tian@intel.com, sanjay.k.kumar@intel.com,
        tony.luck@intel.com, jing.lin@intel.com, dan.j.williams@intel.com,
        kwankhede@nvidia.com, eric.auger@redhat.com, parav@mellanox.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH RFC 04/15] drivers/base: Add support for a new IMS irq
 domain
Message-ID: <20200504121401.GV26002@ziepe.ca>
References: <158751095889.36773.6009825070990637468.stgit@djiang5-desk3.ch.intel.com>
 <158751205175.36773.1874642824360728883.stgit@djiang5-desk3.ch.intel.com>
 <20200423201118.GA29567@ziepe.ca>
 <35f701d9-1034-09c7-8117-87fb8796a017@linux.intel.com>
 <20200503222513.GS26002@ziepe.ca>
 <1ededeb8-deff-4db7-40e5-1d5e8a800f52@linux.intel.com>
 <20200503224659.GU26002@ziepe.ca>
 <8ff2aace-0697-b8ef-de68-1bcc49d6727f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff2aace-0697-b8ef-de68-1bcc49d6727f@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 03, 2020 at 05:25:28PM -0700, Dey, Megha wrote:
> > > The use case if when we have a device assigned to a guest and we
> > > want to allocate IMS(platform-msi) interrupts for that
> > > guest-assigned device. Currently, this is abstracted through a mdev
> > > interface.
> > 
> > And the mdev has the pci_device internally, so it should simply pass
> > that pci_device to the platform_msi machinery.
> 
> hmm i am not sure I follow this. mdev has a pci_device internally? which
> struct are you referring to here?

mdev in general may not, but any ADI trying to use mdev will
necessarily have access to a struct pci_device.

> mdev is merely a micropartitioned PCI device right, which no real PCI
> resource backing. I am not how else we can find the IRQ domain associated
> with an mdev..

ADI always has real PCI resource backing.

Jason
