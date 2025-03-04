Return-Path: <linux-pci+bounces-22823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81032A4D53E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 08:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5BE3AFCBB
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA37D1F5619;
	Tue,  4 Mar 2025 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPOsmW32"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB331C84C9;
	Tue,  4 Mar 2025 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074317; cv=none; b=QVsiGLM/hkAkVE8jg7VqazKurWKU6xG3WzgQwkNvLfTOXM//bE5E3IVpsK3oCVOkugNJYjkC7iWLfgpeD0/S77+cvEz4tyX4xT+Igi/+DYCAzElxPpSDrQ/4kmt3SKCWQ9NfblziWqxtH0lV6lwE3H2i7PDwEBnxLM2BtRkl8ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074317; c=relaxed/simple;
	bh=+ZG9d0xMJRBurf96LSn3na+FqFlH1BReDY4goXCg6Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxmvUjvI6pCzgkHCkleiZWSZzpeYVot82bb011AcztSWZr0OP6Py/47788E36LIdvhu76131n+/Yzd7sFZDC5ZS1jCkHu5tmIZH5Pkfx71IlCDQiTGxolUsEyHO1FL6TpXx4H1AeS/rjMZcHDtGbjo889CfZixDRk98S4UqK8L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPOsmW32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAEBC4CEE8;
	Tue,  4 Mar 2025 07:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741074317;
	bh=+ZG9d0xMJRBurf96LSn3na+FqFlH1BReDY4goXCg6Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UPOsmW32plQUc2mtjyAKB8B+ZGHMM37G3rsz/wVAK8Q37VF6/MEx3WvZSjw2J28GZ
	 nhTIYillEU2XI9wHfXecKHBOs6SqGfZiXNnIKG6nimzamLXsQ4nqXaIWwmBJSZW1QZ
	 HVpqlv4Ct6MHnKJJNJJrdg14aFKloFQA7FpjemzWmBOZMXg5xZWSmq6VCRxv6FEpDy
	 A+tj/9+BzFqheu8Krjnb/uHIA8ucFt166lFUvfQ9XM7eLfqDx12jK7O51ZkyHUdVlB
	 6nt/xWUe3bSaRlBl85x37fL0SsGrGnKNkZlPzxk+pUEIEYdoCupeKgHIpujhvbo2+X
	 MNR4MREDsJE9w==
Date: Tue, 4 Mar 2025 09:45:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
	Aditya Prabhune <aprabhune@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
	Bert Kenward <bkenward@solarflare.com>,
	Matt Carlson <mcarlson@broadcom.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Jean Delvare <jdelvare@suse.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH v4] PCI/sysfs: Change read permissions for VPD attributes
Message-ID: <20250304074512.GC1955273@unreal>
References: <e9943382-8d53-4e28-b600-066ef470f889@app.fastmail.com>
 <20250303211755.GA200634@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250303211755.GA200634@bhelgaas>

On Mon, Mar 03, 2025 at 03:17:55PM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 25, 2025 at 10:05:49PM +0200, Leon Romanovsky wrote:
> > On Tue, Feb 25, 2025, at 20:59, Andrew Lunn wrote:
> > >> Chmod solution is something that I thought, but for now I'm looking
> > >> for the out of the box solution. Chmod still require from
> > >> administrator to run scripts with root permissions.
> > >
> > > It is more likely to be a udev rule.=20
> >=20
> > Udev rule is one of the ways to run such script.
> >=20
> > > systemd already has lots of examples:
> > >
> > > /lib/udev/rules.d/50-udev-default.rules:KERNEL=3D=3D"rfkill", MODE=3D=
"0664"
>=20
> Where are we at with this?  Is a udev rule a feasible solution?

We asked customer if this can work for him and still didn't get answer.
I don't know if they have systemd/udev in their hypervisors.

Thanks

