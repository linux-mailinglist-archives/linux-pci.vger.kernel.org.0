Return-Path: <linux-pci+bounces-33871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F75B22E31
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 18:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9359316A32C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE292FD1C7;
	Tue, 12 Aug 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bs7GHP/z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555B4305E08;
	Tue, 12 Aug 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017037; cv=none; b=F4VeiSfjskYPSZguINa/I4Qg7ABEZWfds0DWMmunrMM23B34iMeFqo9hAxU98ZeH2W/ijW9n7s8A5qibQXfeUQQjt7h1Sk3qP29aOaGYwbin824M1Ub2nCrzyG2t1yqM1mM3W5hv1YRFXYdtMQ7t6TzcX2Z8oOzhOsgWAdokcH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017037; c=relaxed/simple;
	bh=AAG3OKaWicsbt/OyMFmGSnBXL0juwmhtawXjWSgR1/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5HC4eQfXDWACvGcfCq/q8d8iC0Hiuz/bfBD5x5/qI96iQJm0QHPRSxnIsVQxkv4JHObQrVVXl0Ul/VnXQG8/bJOlxK7Mv7KZcWgbpxlA4Kbor8OL0vdcDGLPdENK0Ms2nVEvngHI0ZpdZz2NjM0Hh8q4vlf1povECHo7SzMy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bs7GHP/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6B1C4CEF1;
	Tue, 12 Aug 2025 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755017037;
	bh=AAG3OKaWicsbt/OyMFmGSnBXL0juwmhtawXjWSgR1/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bs7GHP/zuzsqtlCcIJpSXRwExwMr58CJ+BMrS0SN2juA30n2B8IU/NRqaOSx/zEiy
	 2N1nVGTyAmMu9AWE0aE95H/h2irS3N1uLmDWRAH3rEb/flh0lHTC0MEC4GFRZPxz2l
	 ansDfnZAh/jcIqQFfb/yKJOkOuvzylC0FCVnSRkMI7ZBmqsccbMwSOGG9tfsBJb3vE
	 rJenh0FjLvkiGm7857w0+yyk+D8OuQRUmCs9jR03c03Vn6uQZkIcO37b0+1/tSiQdi
	 3gu/EUHclTSMGe97NJTOREJlk9icMeaShCJzRUDGmUKIY4jF844xcufsUKfyQ0zedw
	 RRvwtlgZXQksA==
Date: Tue, 12 Aug 2025 22:13:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	mhi@lists.linux.dev, linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com, 
	quic_mrana@quicinc.com, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
Message-ID: <ycbh6zfwae3q4s6lfxepmxoq32jaqu5i7csa2ayuqaanwbvzvi@id4prmhl3yvh>
References: <20250711213602.GA2307197@bhelgaas>
 <55fc3ae6-ba04-4739-9b89-0356c3e0930c@oss.qualcomm.com>
 <d4078b6c-1921-4195-9022-755845cdb432@oss.qualcomm.com>
 <68a78904-e2c7-4d4d-853d-d9cd6413760e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68a78904-e2c7-4d4d-853d-d9cd6413760e@oss.qualcomm.com>

On Tue, Aug 12, 2025 at 09:35:46AM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/22/2025 4:33 PM, Krishna Chaitanya Chundru wrote:
> > 
> > 
> > On 7/12/2025 4:36 AM, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 7/12/2025 3:06 AM, Bjorn Helgaas wrote:
> > > > On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya
> > > > Chundru wrote:
> > > > > If the driver wants to move to higher data rate/speed than
> > > > > the current data
> > > > > rate then the controller driver may need to change certain
> > > > > votes so that
> > > > > link may come up at requested data rate/speed like QCOM PCIe
> > > > > controllers
> > > > > need to change their RPMh (Resource Power Manager-hardened) state. Once
> > > > > link retraining is done controller drivers needs to adjust their votes
> > > > > based on the final data rate.
> > > > > 
> > > > > Some controllers also may need to update their bandwidth voting like
> > > > > ICC BW votings etc.
> > > > > 
> > > > > So, add pre_link_speed_change() & post_link_speed_change() op to call
> > > > > before & after the link re-train. There is no explicit
> > > > > locking mechanisms
> > > > > as these are called by a single client Endpoint driver.
> > > > > 
> > > > > In case of PCIe switch, if there is a request to change
> > > > > target speed for a
> > > > > downstream port then no need to call these function ops as these are
> > > > > outside the scope of the controller drivers.
> > > > 
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -599,6 +599,24 @@ struct pci_host_bridge {
> > > > >       void (*release_fn)(struct pci_host_bridge *);
> > > > >       int (*enable_device)(struct pci_host_bridge *bridge,
> > > > > struct pci_dev *dev);
> > > > >       void (*disable_device)(struct pci_host_bridge *bridge,
> > > > > struct pci_dev *dev);
> > > > > +    /*
> > > > > +     * Callback to the host bridge drivers to update ICC BW
> > > > > votes, clock
> > > > > +     * frequencies etc.. for the link re-train to come up
> > > > > in targeted speed.
> > > > > +     * These are intended to be called by devices directly
> > > > > attached to the
> > > > > +     * Root Port. These are called by a single client
> > > > > Endpoint driver, so
> > > > > +     * there is no need for explicit locking mechanisms.
> > > > > +     */
> > > > > +    int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
> > > > > +                     struct pci_dev *dev, int speed);
> > > > > +    /*
> > > > > +     * Callback to the host bridge drivers to adjust ICC BW
> > > > > votes, clock
> > > > > +     * frequencies etc.. to the updated speed after link
> > > > > re-train. These
> > > > > +     * are intended to be called by devices directly attached to the
> > > > > +     * Root Port. These are called by a single client Endpoint driver,
> > > > > +     * so there is no need for explicit locking mechanisms.
> > > > 
> > > > No need to repeat the entire comment.  s/.././
> > > > 
> > > > These pointers feel awfully specific for being in struct
> > > > pci_host_bridge, since we only need them for a questionable QCOM
> > > > controller.  I think this needs to be pushed down into qcom somehow as
> > > > some kind of quirk.
> > > > 
> > > Currently these are needed by QCOM controllers, but it may also needed
> > > by other controllers may also need these for updating ICC votes, any
> > > system level votes, clock frequencies etc.
> > > QCOM controllers is also doing one extra step in these functions to
> > > disable and enable ASPM only as it cannot link speed change support
> > > with ASPM enabled.
> > > 
> > Bjorn, can you check this.
> > 
> > For QCOM devices we need to update the RPMh vote i.e a power source
> > votes for the link to come up in required speed. and also we need
> > to update interconnect votes also. This will be applicable for
> > other vendors also.
> > 
> > If this is not correct place I can add them in the pci_ops.
> Bjorn,
> 
> Can you please comment on this.
> 
> Is this fine to move these to the pci_ops of the bridge.
> Again these are not specific to QCOM, any controller driver which
> needs to change their clock rates, ICC bw votes etc needs to have
> these.
> 

No, moving to 'pci_ops' is terrible than having it in 'pci_host_bridge' IMO. If
we want to get rid of these ops, we can introduce a quirk flag in
'pci_host_bridge' and when set, the bwctrl code can disable/enable ASPM
before/after link retrain. This clearly states that the controller is quirky and
we need to disable/enable ASPM.

For setting OPP, you can have a separate callback in 'pci_host_bridge' that just
allows setting OPP *after* retrain, like 'pci_host_bridge:link_change_notify()'.
I don't think you really need to set OPP before retrain though. As even if you
do it pre and post link retrain, there is still a small window where the link
will operate without adequate vote.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

