Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5C3D19D3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 00:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhGUV7A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 17:59:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50068 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhGUV67 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 17:58:59 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626907174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sepRdW6Z8xUqeGbKVOlXDjKfLEa7g37H8/H5BHucBzk=;
        b=iE1g2bwW+vh0PxcRqxasorgULhpgA+baFNg+pthdb8hwv4jCLcskgHD7V1K6WWTDzWlzAO
        R5G7nEAlZn9FZgT9PAdROwPeE6PGqJEVSMVCDNOB+FXWGUps8Ey+0ZQaWDnZ0k9oeR4vfR
        +2blq7tajjhq2fiBxKynMuZ1MsQaK/MyuSJOHd/4MFPHFdcExS2C2xwaFS3am5ZqQnIftx
        YHUzjaLdRFss8fRMtxOhm+0xVUuh7XkSLT1DJHf1eAZ6HLT2EqLkMZjtfQV0La4kofwJok
        XsmVnGKDJI4kuMkHIP+5GpRN8TcbfPd26pY0SJwattzfCUU+Ly7+/V0TLR6vBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626907174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sepRdW6Z8xUqeGbKVOlXDjKfLEa7g37H8/H5BHucBzk=;
        b=AXZrf7eg1fpSXzsQ/udt1aXb02LifqLGDkbR7NwAky0yHsQm4gw7WnHedaZYVdxccDQ6Hp
        Yp5SbBBQHpryDtBw==
To:     "Raj\, Ashok" <ashok.raj@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 0/8] PCI/MSI, x86: Cure a couple of inconsistencies
In-Reply-To: <20210721211036.GA676232@otc-nc-03>
References: <20210721191126.274946280@linutronix.de> <20210721211036.GA676232@otc-nc-03>
Date:   Thu, 22 Jul 2021 00:39:29 +0200
Message-ID: <875yx3p9zy.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21 2021 at 14:10, Ashok Raj wrote:

> On Wed, Jul 21, 2021 at 09:11:26PM +0200, Thomas Gleixner wrote:
>> A recent discussion about the PCI/MSI management for virtio unearthed a
>
> nit:
> virtio or VFIO? :-)

VFIO of course. 
