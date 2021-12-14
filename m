Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7250B474528
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 15:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhLNOdk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 09:33:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47362 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbhLNOdj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 09:33:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DE73B819D0;
        Tue, 14 Dec 2021 14:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5977FC34601;
        Tue, 14 Dec 2021 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639492417;
        bh=1hcDzTXoYi4oTU+WneZ9qf7VczXx7+1E5fhQ6WPKjQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Beu7vfhlliFbF8zEA/YWLDfxmwWPvfQPPgZBVkLA3Y2p/ySM7lOQSvfTpdVZJl5lt
         nvrqKqYYwCKuoIt5bkCXyfYen4qFWUMPs+iUeqgsmfUmt3PIIJfMvHtZElRKVcrIoy
         0eyKsJUMxvQEJN3ub8IW1lo306p1Qcr8UGKRppFF+bvO6nr450wnMhfIOvX8Dpk8XQ
         UJuXGDGqqXXQG0Mylrmdp1CiIkJ5RDRdA8LPSk5/HoWpw7rb6Htqk7lA1EKqs3fa/G
         039HYrNXvRDt+mzfqXXjH+gufQKMMN47qAmgvibkLe5kJMnBhI23DAIaT2paltqgsz
         iHzNsAh0Dhl1A==
Date:   Tue, 14 Dec 2021 20:03:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, kishon@ti.com, robh@kernel.org,
        galak@kernel.crashing.org, shawnguo@kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v7 2/8] dt-bindings: phy: Add imx8 pcie phy driver support
Message-ID: <YbirPXu4OkCPFfMj@matsya>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-3-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638432158-4119-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02-12-21, 16:02, Richard Zhu wrote:
> Add dt-binding for the standalone i.MX8 PCIe PHY driver.

Applied, thanks

> 
-- 
~Vinod
