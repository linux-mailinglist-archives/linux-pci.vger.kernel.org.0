Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4C02C4108
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 14:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgKYNUX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 08:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgKYNUX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Nov 2020 08:20:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC96C0613D4;
        Wed, 25 Nov 2020 05:20:23 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606310421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fb1yTCfVx8pU95ckndYGNJP7rgnPUEX5zBWS1/t7lBo=;
        b=zfCRgVqmQUanbSMxfM/AJBOVwzgLL+DQrzJCrYt0JDvFzGOKPG77UXL46Q+/Y0xr3vQD8c
        vcRH8CqoiNaIqybeabsAF6TpLsiPmS4Xj+ZfYrP5yjM5hmLL9arfuIJZFRn9fv7y8sQN/p
        fHmhReSvpEcJTQJKF+c2m4LXh1F5KGF6G+Nb7l5u8wgFx3fNGv99Jo/Ou3xlPK3CNCfGZV
        4eh6SQuD7NzGO2bFdt9HxPc64Wjtr+ulOR5XtvlplLP0xQw4fsmppWiq23ceve/9jlG0iJ
        TjUp/wuqXY1iAf9Ge2dpXQlO7/fdsL5h9FWyj/Gn9P2fh9t1pki7H9U36BR85Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606310421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fb1yTCfVx8pU95ckndYGNJP7rgnPUEX5zBWS1/t7lBo=;
        b=RVIMh+DQ2MU+geLoHmWuSvDZ1IFvbZM1Ns3HEQAkmO0PTHfdyXlwZqOtkQjMfbj9D4C0YM
        bRnfHM/KOZ1pynAw==
To:     Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 1/2] genirq: add an irq_create_mapping_affinity() function
In-Reply-To: <20201125111657.1141295-2-lvivier@redhat.com>
References: <20201125111657.1141295-1-lvivier@redhat.com> <20201125111657.1141295-2-lvivier@redhat.com>
Date:   Wed, 25 Nov 2020 14:20:21 +0100
Message-ID: <87sg8xk1yi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Laurent,

On Wed, Nov 25 2020 at 12:16, Laurent Vivier wrote:

The proper subsystem prefix is: 'genirq/irqdomain:' and the first letter
after the colon wants to be uppercase.

> This function adds an affinity parameter to irq_create_mapping().
> This parameter is needed to pass it to irq_domain_alloc_descs().

A changelog has to explain the WHY. 'The parameter is needed' is not
really useful information.

Thanks,

        tglx

