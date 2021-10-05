Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C004222D3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhJEJ5j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 5 Oct 2021 05:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbhJEJ5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 05:57:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B646C06161C
        for <linux-pci@vger.kernel.org>; Tue,  5 Oct 2021 02:55:48 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mXhAb-00078O-Cj; Tue, 05 Oct 2021 11:55:33 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1mXhAZ-0004kt-4E; Tue, 05 Oct 2021 11:55:31 +0200
Message-ID: <8c26c28450abd8a3a183fdbef42d6c0468f4ec7d.camel@pengutronix.de>
Subject: Re: [PATCH 2/5] reset: tegra-bpmp: Handle errors in BPMP response
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Mikko Perttunen <mperttunen@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, krzysztof.kozlowski@canonical.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date:   Tue, 05 Oct 2021 11:55:31 +0200
In-Reply-To: <20210915085517.1669675-2-mperttunen@nvidia.com>
References: <20210915085517.1669675-1-mperttunen@nvidia.com>
         <20210915085517.1669675-2-mperttunen@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2021-09-15 at 11:55 +0300, Mikko Perttunen wrote:
> The return value from tegra_bpmp_transfer indicates the success or
> failure of the IPC transaction with BPMP. If the transaction
> succeeded, we also need to check the actual command's result code.
> Add code to do this.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Thank you, applied to reset/fixes.

regards
Philipp
