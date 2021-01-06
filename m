Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAF32EC64C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 23:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbhAFWkp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 17:40:45 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:53694 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbhAFWko (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jan 2021 17:40:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 8E5946BB;
        Wed,  6 Jan 2021 23:40:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vnVwzdxEFMXf; Wed,  6 Jan 2021 23:40:01 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id A9FB643F;
        Wed,  6 Jan 2021 23:40:01 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kxHTE-006P4i-FV; Wed, 06 Jan 2021 23:40:00 +0100
Date:   Wed, 6 Jan 2021 23:40:00 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: Are AER corrected errors worrying?
Message-ID: <20210106224000.skryo2aijhfiomfw@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Keith Busch <kbusch@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
References: <20210101224028.4akud7meibjavvtf@function>
 <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
 <20210104201247.5k47gueib3cw4sfr@function>
 <20210104213648.enkuq5e2o6adbiur@function>
 <20210106202823.ehdkno3inlzszqtb@function>
 <20210106214808.GA1280721@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106214808.GA1280721@dhcp-10-100-145-180.wdc.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Keith Busch, le mer. 06 janv. 2021 13:48:08 -0800, a ecrit:
> On Wed, Jan 06, 2021 at 09:28:23PM +0100, Samuel Thibault wrote:
> > Is there more I can provide to investigate if that can somehow be fixed
> > in the driver? I guess I can safely use the system with pcie_aspm=off?
> > (the energy saving seems neglectible)
> 
> I don't think there's more to do from the kernel or driver beyond
> disabling usage of the problematic feature. I think a proper fix would
> have to come from the hardware vendor.

Ok, thanks!

Samuel
