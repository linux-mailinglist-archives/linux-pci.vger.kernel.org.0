Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DFE9FB13
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 09:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfH1HBm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 03:01:42 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:56767 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfH1HBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 03:01:42 -0400
Received: from windsurf.home (atoulouse-659-1-185-116.w90-30.abo.wanadoo.fr [90.30.228.116])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3B35E200004;
        Wed, 28 Aug 2019 07:01:40 +0000 (UTC)
Date:   Wed, 28 Aug 2019 09:01:39 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Move static keyword to the front of declarations
 in pci-bridge-emul.c
Message-ID: <20190828090139.713b047f@windsurf.home>
In-Reply-To: <20190827233017.GK9987@google.com>
References: <20190826151436.4672-1-kw@linux.com>
        <20190827233017.GK9987@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Tue, 27 Aug 2019 18:30:17 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Thomas]
> 
> On Mon, Aug 26, 2019 at 05:14:36PM +0200, Krzysztof Wilczynski wrote:
> > Move the static keyword to the front of declarations of
> > pci_regs_behavior and pcie_cap_regs_behavior, and resolve
> > compiler warning that can be seen when building with
> > warnings enabled (W=1).  
> 
> It would be useful to include the compiler warning in the commit log.
> 
> I notice there are a few similar occurrences elsewhere in the tree:
> 
>   arch/csky/kernel/perf_event.c:const static struct of_device_id csky_pmu_of_device_ids[] = {
>   arch/nds32/kernel/perf_event_cpu.c:const static struct of_device_id cpu_pmu_of_device_ids[] = {
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct msm_dsi_host_cfg_ops msm_dsi_6g_host_ops = {
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct msm_dsi_host_cfg_ops msm_dsi_6g_v2_host_ops = {
>   drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:const static struct wiphy_iftype_ext_capab he_iftypes_ext_capa[] = {
>   fs/unicode/utf8-selftest.c:const static struct {
>   fs/unicode/utf8-selftest.c:const static struct {
> 
> Those should probably be fixed, too (but in separate patches since
> other maintainers would take them).
> 
> > Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
