Return-Path: <linux-pci+bounces-36297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685BB5A19D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 21:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1453C527AE2
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14527E7DA;
	Tue, 16 Sep 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilqQQHkz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1027E07A;
	Tue, 16 Sep 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758052148; cv=none; b=jKgKXcFOoNabrB6RlqcGAPQQ71FV3hE0tDKijUyGgQlU23G9s7f2El3rTHXB7U6gVyD+q+WpqIgBKYFBXis5sJrUPpVRpZUKwzZXsfZUzXo9cEPUlMTLuoW2+FTxSuidpnMCy7EMaK7chuoqxgh2h3ehaFs+z/qXmDwezUN5AIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758052148; c=relaxed/simple;
	bh=dYvAKxDefyFeKKvefy9yPkFzuUPPoG8H5WMFizwxFII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q6Ea4GpG5jA3L466TrEPLdlGUnvIzjXnmVJUIP8Jfy4j0iZF9oZhEN0otjC1Wca8bdfxLry9iUqRk3OUIx3vo34tXbQo1eb04309d/Lf8Xkw1ZOle6Vd+nzkpCKIfaoU7nude0qMxSSODh7sD9QNBubKjjYVX9s9uFCnQvluG00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilqQQHkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C40C4CEEB;
	Tue, 16 Sep 2025 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758052148;
	bh=dYvAKxDefyFeKKvefy9yPkFzuUPPoG8H5WMFizwxFII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ilqQQHkzcWtFDAcyeIwcyThPhLEzawKBlIYuNrFMxWEfXBjUr8NJMD38tNVTstw6+
	 t+91/2qZkSTnUPKMlh5x7lfpoczOmb2Z6TRoqUFqIHUYa4yBYEaLgKsLaH45RrtG1l
	 j7kDDhOHZJJUoKB5Y+VwVigeMveDNdrq4Xh4Pw8/+kTfNxvhkSas1Tqw8KX/IJtVyo
	 GeVnCItdxJnNwU/+d+81qmdhl1y8kJT+iueqf2X8uEc2sxwNVYmgUJva0t0+NAyqMV
	 UIxpOySIXCIEP3ps0A4POR14O7ei33zDG2TO48qetpeiPnebd2DX8kL7BdmDLWHllX
	 1Z1My30Xd18mg==
Date: Tue, 16 Sep 2025 14:49:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 3/4] PCI: qcom: Parse PERST# from all PCIe bridge nodes
Message-ID: <20250916194906.GA1738942@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <blgpkdfx333h6vu25peatl3bbxffe5vuovgmae4osuoahuiryp@owrxkcv63kxb>

On Mon, Sep 15, 2025 at 06:23:45PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Sep 12, 2025 at 06:28:11PM GMT, Bjorn Helgaas wrote:
> > On Fri, Sep 12, 2025 at 02:05:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > 
> > > Devicetree schema allows the PERST# GPIO to be present in all
> > > PCIe bridge nodes, not just in Root Port node. But the current
> > > logic parses PERST# only from the Root Port nodes. Though it is
> > > not causing any issue on the current platforms, the upcoming
> > > platforms will have PERST# in PCIe switch downstream ports also.
> > > So this requires parsing all the PCIe bridge nodes for the
> > > PERST# GPIO.
> > > 
> > > Hence, rework the parsing logic to extend to all PCIe bridge
> > > nodes starting from the Root Port node. If the 'reset-gpios'
> > > property is found for a PCI bridge node, the GPIO descriptor
> > > will be stored in qcom_pcie_perst::desc and added to the
> > > qcom_pcie_port::perst list.
> > 
> > The switch part doesn't seem qcom specific.  Aren't we going to
> > end up with lots of drivers reimplementing something like the
> > qcom_pcie_port.perst list?
> 
> If this kind of switch is attached to other platforms, then yes.
> Right now, Qcom host is the only known DT based host platform that
> has seen this requirement.

So I guess the issue here is that pwrctrl controls power to a slot
below a Switch Downstream Port, and we want pwrctrl to also control
PERST# to that same slot so that pwrctrl can power up the slot and
then deassert PERST# to the slot later, e.g., after a T_PVPERL delay?

Seems like whatever parses the devicetree power regulator information
for the slot should also parse the PERST# GPIO for the slot.

Bjorn

