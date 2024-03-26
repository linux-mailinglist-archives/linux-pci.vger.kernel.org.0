Return-Path: <linux-pci+bounces-5209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614FE88CFD8
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 22:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAEC81C3629F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 21:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EA313D538;
	Tue, 26 Mar 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+1kW46n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08C1E884;
	Tue, 26 Mar 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487827; cv=none; b=J8xI4sQNPmRVqNo1XLlnBo2cgiwTnAcgsldgpkmZ05VnRujobVB0C52234GShUKeEh+u0IQw2/lBWC57V8vUkXKVA/ZpN0KrPFY1kFjU7m5vA7UVsx3C1aBpEltjaXxFO2y7Sr8arxJIf3khJrAJzuqp1jR/HpWzVlawSYD9pLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487827; c=relaxed/simple;
	bh=fzaOToqMJEgFTyVUFRzzeGvuwsRaqDDI/fsy1nM+zeA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=L2qmmP8RtlLQFW+8w57rPrj5nWuOAfY+8kcKZFKq0ZkzDpo3OAHMjjsUBeS9QSpTLK+T/LIE7m29UMJ4rDyoYm5o8POr7FK6psmizpXwLLHFi/gBDFdO6DWC2jI8fyW8ZN4jsSrzci5clAeWWGBVlwJLSYLaviI3UH99IbKDDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+1kW46n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BCFC433F1;
	Tue, 26 Mar 2024 21:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711487826;
	bh=fzaOToqMJEgFTyVUFRzzeGvuwsRaqDDI/fsy1nM+zeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=d+1kW46nvwqIQCN9jRXyPqYBRK8j84s69iFA4xc+ygbdi2Kzue4l86ra0M1vicV4n
	 mYVAwY4MAvY6SpplkMVCD+/gWEbpKkstl695QI0PuDdubcM7eeVqPCj5fkYdSpKZOi
	 NDVlPGOi1o74o0VFZdb246sVnVu0K5bsiBfT+pEglLmwFvIRoexaEyApuWUIyBUtA7
	 7HY2PVui1erJIf0Bkbh/U1o4mdwI3XjcCvs/VyE7vG/BaJZb+jKkGY1dRN8xsH+5FL
	 DfncLKr7mHdEosTuC1kgFvz+mHc9l+TUPudzMIagonCYqgusYdfDANFwebCeC8ZtA5
	 pHGnSST7cTmdA==
Date: Tue, 26 Mar 2024 16:17:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Grant Grundler <grundler@chromium.org>,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	mahesh@linux.ibm.com, oohall@gmail.com,
	rajat.khandelwal@linux.intel.com, rajatja@chromium.org
Subject: Re: [PATCHv3 pci-next 1/2] PCI/AER: correctable error message as
 KERN_INFO
Message-ID: <20240326211705.GA1497507@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1d7b4c9-b47e-4b59-a4d5-e091bbbff5d7@linux.intel.com>

On Tue, Mar 26, 2024 at 09:39:54AM +0800, Ethan Zhao wrote:
> On 3/25/2024 6:15 PM, Xi Ruoyao wrote:
> > On Mon, 2024-03-25 at 16:45 +0800, Ethan Zhao wrote:
> > > On 3/25/2024 1:19 AM, Xi Ruoyao wrote:
> > > > On Mon, 2023-09-18 at 14:39 -0500, Bjorn Helgaas wrote:
> > > > > On Mon, Sep 18, 2023 at 07:42:30PM +0800, Xi Ruoyao wrote:
> > > > > > ...
> > > > > > My workstation suffers from too much correctable AER reporting as well
> > > > > > (related to Intel's errata "RPL013: Incorrectly Formed PCIe Packets May
> > > > > > Generate Correctable Errors" and/or the motherboard design, I guess).
> > > > > We should rate-limit correctable error reporting so it's not
> > > > > overwhelming.
> > > > > 
> > > > > At the same time, I'm *also* interested in the cause of these errors,
> > > > > in case there's a Linux defect or a hardware erratum that we can work
> > > > > around.  Do you have a bug report with any more details, e.g., a dmesg
> > > > > log and "sudo lspci -vv" output?
> > > > Hi Bjorn,
> > > > 
> > > > Sorry for the *very* late reply (somehow I didn't see the reply at all
> > > > before it was removed by my cron job, and now I just savaged it from
> > > > lore.kernel.org...)
> > > > 
> > > > The dmesg is like:
> > > > 
> > > > [  882.456994] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:00:1c.1
> > > > [  882.457002] pcieport 0000:00:1c.1: AER: found no error details for 0000:00:1c.1
> > > > [  882.457003] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:06:00.0
> > > > [  883.545763] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:00:1c.1
> > > > [  883.545789] pcieport 0000:00:1c.1: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Receiver ID)
> > > > [  883.545790] pcieport 0000:00:1c.1:   device [8086:7a39] error status/mask=00000001/00002000
> > > > [  883.545792] pcieport 0000:00:1c.1:    [ 0] RxErr                  (First)
> > > > [  883.545794] pcieport 0000:00:1c.1: AER:   Error of this Agent is reported first
> > > > [  883.545798] r8169 0000:06:00.0: PCIe Bus Error: severity=Correctable, type=Physical Layer, (Transmitter ID)
> > > > [  883.545799] r8169 0000:06:00.0:   device [10ec:8125] error status/mask=00001101/0000e000
> > > > [  883.545800] r8169 0000:06:00.0:    [ 0] RxErr                  (First)
> > > > [  883.545801] r8169 0000:06:00.0:    [ 8] Rollover
> > > > [  883.545802] r8169 0000:06:00.0:    [12] Timeout
> > > > [  883.545815] pcieport 0000:00:1c.1: AER: Correctable error message received from 0000:00:1c.1
> > > > [  883.545823] pcieport 0000:00:1c.1: AER: found no error details for 0000:00:1c.1
> > > > [  883.545824] pcieport 0000:00:1c.1: AER: Multiple Correctable error message received from 0000:06:00.0
> > > > 
> > > > lspci output attached.
> > > > 
> > > > Intel has issued an errata "RPL013" saying:
> > > > 
> > > > "Under complex microarchitectural conditions, the PCIe controller may
> > > > transmit an incorrectly formed Transaction Layer Packet (TLP), which
> > > > will fail CRC checks. When this erratum occurs, the PCIe end point may
> > > > record correctable errors resulting in either a NAK or link recovery.
> > > > Intel® has not observed any functional impact due to this erratum."
> > > > 
> > > > But I'm really unsure if it describes my issue.
> > > > 
> > > > Do you think I have some broken hardware and I should replace the CPU
> > > > and/or the motherboard (where the r8169 is soldered)?  I've noticed that
> > > > my 13900K is almost impossible to overclock (despite it's a K), but I've
> > > > not encountered any issue other than these AER reporting so far after I
> > > > gave up overclocking.
> > > Seems there are two r8169 nics on your board, only 0000:06:00.0 reports
> > > aer errors, how about another one the 0000:07:00.0 nic ?
> > It never happens to 0000:07:00.0, even if I plug the ethernet cable into
> > it instead of 0000:06:00.0.
> 
> So something is wrong with the physical layer, I guess.
> 
> > Maybe I should just use 0000:07:00.0 and blacklist 0000:06:00.0 as I
> > don't need two NICs?
> 
> Yup,
> ratelimit the AER warning is another choice instead of change WARN to INFO.
> if corrected error flood happens, even the function is working, suggests
> something was already wrong, likely will be worse, that is the meaning of
> WARN I think.

We should fix this.  IMHO Correctable Errors should be "info" level,
non-alarming, and rate-limited.  They're basically hints about link
integrity.

Bjorn

