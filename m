Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7D218D879
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 20:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgCTTh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 15:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgCTTh6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 15:37:58 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F6D720777;
        Fri, 20 Mar 2020 19:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584733077;
        bh=OcAj1mRF3Wt0azKQU+0IX3Ycr8E2bKuEFpGJcAvc+tc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KvmFrZ52uZRJi9S5/w+0AuR8CoogezFW41f26E6VQGaGt7YSt3lscU75FgNYsBpL7
         t4SynEUArqu65qcKHfHgkkcSId8a5L6gjHa+pL8itdh71BywpSxE2Pz5J4qA+/RdqM
         c00MY4GD8jii+2ob7HGmrhLyoinGpvm91vg0yXw8=
Date:   Fri, 20 Mar 2020 14:37:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Sham Muthayyan <smuthayy@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] pcie: qcom: add Force GEN1 support
Message-ID: <20200320193756.GA249654@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-10-ansuelsmth@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 07:34:52PM +0100, Ansuel Smith wrote:
> From: Sham Muthayyan <smuthayy@codeaurora.org>
> 
> Add Force GEN1 support needed in some ipq806x board
> that needs to limit some pcie line to gen1 for some
> hardware limitation

Usual commit log comments.

> +	uint32_t force_gen1;

unsigned int force_gen1 : 1

> +	of_property_read_u32(np, "force_gen1", &force_gen1);
> +	pcie->force_gen1 = force_gen1;

I think there's a more or less standard property you can use for this
instead of inventing a new one specific to this device.

Documentation/devicetree/bindings/pci/pci.txt:
"max-link-speed"
