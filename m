Return-Path: <linux-pci+bounces-7136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B018BD797
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 00:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03B11C20E7B
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 22:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAAB136E3B;
	Mon,  6 May 2024 22:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIRSi6hs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCAE4CB58;
	Mon,  6 May 2024 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715034713; cv=none; b=WFSkhBgJlBnrIC5j2pPs9PQfQh13yB49NQVZQYq1AS587J/n5PnBGg4cOuPsIVR7CWQgq/RQJzoGi8he2Pj2xuT23qptaXwGriRNcvz/SQlUqPTTs7L/clEUN05oYjMGeLwDVd63DgVq9tLMGgtOFjeyN0KAQcBJQqmctk9X3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715034713; c=relaxed/simple;
	bh=MxL9KyUQPXgpKCWFrnBl9eSSaERBnN6J7itAyM6eMes=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JTKmu0TRNS8CVj0UcPhYBrpPTMGRM7GYDtc3GIzoqhN9dqu+ldTfOc2XsLD69f9ieRxp1Wmx8vmL9yuI4jJAmwZ8UGzCf6BcYaCPyTrPwLPDEnj2dxdhGIi7YlFxsmV7Wf5u8+acux0fNcMejGeZ6AMTTJzEJK6pqpSCwD9EOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIRSi6hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3494BC116B1;
	Mon,  6 May 2024 22:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715034711;
	bh=MxL9KyUQPXgpKCWFrnBl9eSSaERBnN6J7itAyM6eMes=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eIRSi6hscHmlNqhd4Pn3Wy3brRAg9/VVqWitd16gHerwBPJKjkCOXqeYEKi5pxrMC
	 rQPjLX22AHmvR9Qah7bPH9D/twK37kpQdEn71ksHdBo6DmBOlfhoyHmeF+rZm4Icje
	 1lfwURYuPQDBcwP7UO5mhGof+rXQAGHPHZwSdEmU2PctUfIc1WWaxa6XGSsRmI1mx2
	 EL0GVFkWi5lFuRPvtwUx8IbXKRVMrRn+yS6IJCMyzXQJiZpYIo+J2cowpMyJkk5Jmn
	 buU6xGYoNyttwHUn4+8mda4H18FG3aWmAGk2mzpv/cGdTn4om8A2+zaqOPxGGwSl08
	 b3tKUTYcrFc9A==
Date: Mon, 6 May 2024 17:31:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Phil Elwell <phil@raspberrypi.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 0/4] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <20240506223149.GA1708699@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNynMc7-zZ0No0Y30of+uPiz0mSL9brV3R=UGJNC6ytoxg@mail.gmail.com>

On Tue, Apr 30, 2024 at 05:02:45PM -0400, Jim Quinlan wrote:
> On Wed, Apr 3, 2024 at 5:39 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> >
> > v9 -- v8 was setting an internal bus timeout to accomodate large L1 exit
> >       latencies.  After meeting the PCIe HW team it was revealed that the
> >       HW default timeout value was set low for the purposes of HW debugging
> >       convenience; for nominal operation it needs to be set to a higher
> >       value independent of this submission's purpose.  This is now a
> >       separate commit.
> 
> Bjorn,
> 
> Did you have some time to look at this?  Do you have any comments or questions?

Sorry, I didn't realize you were waiting on me.  I think Krzysztof W.
will ultimately take care of these.

I have some minor comments but overall I'm fine with this.

> >    -- With v8, Bjorne asked what was preventing a device from exceeding the
> >       time required for the above internal bus timeout.  The answer to this
> >       is for us to set the endpoints' max latency {no-,}snoop value to
> >       something below this internal timeout value.  If the endpoint
> >       respects this value as it should, it will not send an LTR request
> >       with a larger latency value and not put itself in a situation
> >       that requires more latency than is possible for the platform.
> >
> >       Typically, ACPI or FW sets these max latency values.  In most of our
> >       systems we do not have this happening so it is up to the RC driver to
> >       set these values in the endpoint devices.  If the endpoints already
> >       have non-zero values that are lower than what we are setting, we let
> >       them be, as it is possible ACPI or FW set them and knows something
> >       that we do not.
> >
> >    -- The "clkreq" commit has only been changed to remove the code that was
> >       setting the timeout value, as this code is now its own commit.
> >
> > v8 -- Un-advertise L1SS capability when in "no-l1ss" mode (Bjorn)
> >    -- Squashed last two commits of v7 (Bjorn)
> >    -- Fix DT binding description text wrapping (Bjorn)
> >    -- Fix incorrect Spec reference (Bjorn)
> >          s/PCIe Spec/PCIe Express Mini CEM 2.1 specification/
> >    -- Text substitutions (Bjorn)
> >          s/WRT/With respect to/
> >          s/Tclron/T_CLRon/
> >
> > v7 -- Manivannan Sadhasivam suggested (a) making the property look like a
> >       network phy-mode and (b) keeping the code simple (not counting clkreq
> >       signal appearances, un-advertising capabilites, etc).  This is
> >       what I have done.  The property is now "brcm,clkreq-mode" and
> >       the values may be one of "safe", "default", and "no-l1ss".  The
> >       default setting is to employ the most capable power savings mode.
> >
> > v6 -- No code has been changed.
> >    -- Changed commit subject and comment in "#PERST" commit (Bjorn, Cyril)
> >    -- Changed sign-off and author email address for all commits.
> >       This was due to a change in Broadcom's upstreaming policy.
> >
> > v5 -- Remove DT property "brcm,completion-timeout-us" from
> >       "DT bindings" commit.  Although this error may be reported
> >       as a completion timeout, its cause was traced to an
> >       internal bus timeout which may occur even when there is
> >       no PCIe access being processed.  We set a timeout of four
> >       seconds only if we are operating in "L1SS CLKREQ#" mode.
> >    -- Correct CEM 2.0 reference provided by HW engineer,
> >       s/3.2.5.2.5/3.2.5.2.2/ (Bjorn)
> >    -- Add newline to dev_info() string (Stefan)
> >    -- Change variable rval to unsigned (Stefan)
> >    -- s/implementaion/implementation/ (Bjorn)
> >    -- s/superpowersave/powersupersave/ (Bjorn)
> >    -- Slightly modify message on "PERST#" commit.
> >    -- Rebase to torvalds master
> >
> > v4 -- New commit that asserts PERST# for 2711/RPi SOCs at PCIe RC
> >       driver probe() time.  This is done in Raspian Linux and its
> >       absence may be the cause of a failing test case.
> >    -- New commit that removes stale comment.
> >
> > v3 -- Rewrote commit msgs and comments refering panics if L1SS
> >       is enabled/disabled; the code snippet that unadvertises L1SS
> >       eliminates the panic scenario. (Bjorn)
> >    -- Add reference for "400ns of CLKREQ# assertion" blurb (Bjorn)
> >    -- Put binding names in DT commit Subject (Bjorn)
> >    -- Add a verb to a commit's subject line (Bjorn)
> >    -- s/accomodat(\w+)/accommodat$1/g (Bjorn)
> >    -- Rewrote commit msgs and comments refering panics if L1SS
> >       is enabled/disabled; the code snippet that unadvertises L1SS
> >       eliminates the panic scenario. (Bjorn)
> >
> > v2 -- Changed binding property 'brcm,completion-timeout-msec' to
> >       'brcm,completion-timeout-us'.  (StefanW for standard suffix).
> >    -- Warn when clamping timeout value, and include clamped
> >       region in message. Also add min and max in YAML. (StefanW)
> >    -- Qualify description of "brcm,completion-timeout-us" so that
> >       it refers to PCIe transactions. (StefanW)
> >    -- Remvove mention of Linux specifics in binding description. (StefanW)
> >    -- s/clkreq#/CLKREQ#/g (Bjorn)
> >    -- Refactor completion-timeout-us code to compare max and min to
> >       value given by the property (as opposed to the computed value).
> >
> > v1 -- The current driver assumes the downstream devices can
> >       provide CLKREQ# for ASPM.  These commits accomodate devices
> >       w/ or w/o clkreq# and also handle L1SS-capable devices.
> >
> >    -- The Raspian Linux folks have already been using a PCIe RC
> >       property "brcm,enable-l1ss".  These commits use the same
> >       property, in a backward-compatible manner, and the implementaion
> >       adds more detail and also automatically identifies devices w/o
> >       a clkreq# signal, i.e. most devices plugged into an RPi CM4
> >       IO board.
> >
> > Jim Quinlan (4):
> >   dt-bindings: PCI: brcmstb: Add property "brcm,clkreq-mode"
> >   PCI: brcmstb: Set reasonable value for internal bus timeout
> >   PCI: brcmstb: Set downstream maximum {no-}snoop LTR values
> >   PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream
> >     device
> >
> >  .../bindings/pci/brcm,stb-pcie.yaml           |  18 ++
> >  drivers/pci/controller/pcie-brcmstb.c         | 161 +++++++++++++++++-
> >  2 files changed, 170 insertions(+), 9 deletions(-)
> >
> >
> > base-commit: 9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e
> > --
> > 2.17.1
> >



