Return-Path: <linux-pci+bounces-31918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3110B01785
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 11:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39191565237
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E51D27A10C;
	Fri, 11 Jul 2025 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvwysewU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F964279903;
	Fri, 11 Jul 2025 09:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225708; cv=none; b=Stx1PPaZHKj4GFHyjaQtNYd5mvJUvsjOBiAhKLrg3pF+sIqT58aJHIxuI+5BrvZ87sSgxrCv6BdPni305oVpY8LPsdB47JZsHZi2X35iQ2zziGobLrQw7rKuA6tdvYszNry82/nHiHDcDw1nLwbZqz1cO7a0PRM6jIEyzY2txVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225708; c=relaxed/simple;
	bh=ne44bbTYibQEKk06zvdeZXV0JGbJvTKjbOlOl+PFBzk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=riYxoVZWkzEU35ehYLdzQsiOXocPGq1C2ytYkF9jNq4Y6bFeJiBiYkXnA3uZX1N20e+W1CYZLQNqtfewwK4mBmHq3hWtf9zoR9vxHCWL5giI/vn/pJPLHp8L8jhAU7hBJ0KB9O37RCewYiNsh0ogi5nmPef02Gd+HQ8qXyRF0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvwysewU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752225706; x=1783761706;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ne44bbTYibQEKk06zvdeZXV0JGbJvTKjbOlOl+PFBzk=;
  b=nvwysewU2S+nZlK4caS8sdHhQHk/6mBK74hxvfV876P8fBRxyyFXVFGS
   CEQiysWAmsWdjn+vWx3H5ZtfmRJjnol6lve7mqvno06S658ynV+ivnDVo
   BwIv9aOf6BzniX7fmFa6epkkzDjHhp/kpCK8eLsogrMnTdfNxnf++hgU6
   djfubIDc/ysKi+JXLXp1TdwOj1LnNCQSgKdHCpYHO4mUWIisUR7gHqFlw
   rudkwGuDqWV7FmeVFx3EY5ukk5u9Zk7+3Aoe76cVPkuW5gLkPjMxzmS2T
   NHpXVamqg/y601/Xu02oSBf3+0mEyyyLud1VquTSFbSZNQDnpX1gztb9i
   w==;
X-CSE-ConnectionGUID: vLTQtjgZR72oWYoBbLrtrw==
X-CSE-MsgGUID: TcuCp9hPQv+OK8Alr1eVoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="79956152"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="79956152"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:21:45 -0700
X-CSE-ConnectionGUID: PvcNX0ouT4iYz06C15Oy9w==
X-CSE-MsgGUID: xk3fq7z+Tg23rwGF7zV5Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="160872671"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.249])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 02:21:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 11 Jul 2025 12:21:36 +0300 (EEST)
To: Manivannan Sadhasivam <mani@kernel.org>
cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
    Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
    linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
    qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
    quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
    Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 06/11] PCI/ASPM: Clear aspm_disable as part of
 __pci_enable_link_state()
In-Reply-To: <irnkdlrmlozp7joydgnawfuivl2nnuxsb2t4osgxzbtyrfzd3n@7dhzjcd42aiw>
Message-ID: <c7d4288d-4d0e-a3c2-83d2-c3f1b282d4ac@linux.intel.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com> <20250609-mhi_bw_up-v4-6-3faa8fe92b05@qti.qualcomm.com> <qo6mb3qlt3xpuvhepwcv6be4wd53neee2t6buzk4tdiy22xsub@vu7lykp3rnu2> <226bab3a-54e5-94ad-9d84-0b82f9dc4e2f@linux.intel.com>
 <2a18cf9e-1dd2-4e09-81f4-eb1d07324c8e@oss.qualcomm.com> <irnkdlrmlozp7joydgnawfuivl2nnuxsb2t4osgxzbtyrfzd3n@7dhzjcd42aiw>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1361302077-1752225289=:933"
Content-ID: <0e71b6ef-a263-4169-3869-f785789a47fb@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1361302077-1752225289=:933
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <6c0bed1f-8dc1-cb12-cf09-a337d07698de@linux.intel.com>

On Fri, 11 Jul 2025, Manivannan Sadhasivam wrote:

> On Wed, Jul 09, 2025 at 06:01:22PM GMT, Krishna Chaitanya Chundru wrote:
> >=20
> >=20
> > On 7/9/2025 2:40 PM, Ilpo J=E4rvinen wrote:
> > > On Tue, 8 Jul 2025, Manivannan Sadhasivam wrote:
> > >=20
> > > > On Mon, Jun 09, 2025 at 04:21:27PM GMT, Krishna Chaitanya Chundru w=
rote:
> > > > > ASPM states are not being enabled back with pci_enable_link_state=
() when
> > > > > they are disabled by pci_disable_link_state(). This is because of=
 the
> > > > > aspm_disable flag is not getting cleared in pci_enable_link_state=
(), this
> > > > > flag is being properly cleared when ASPM is controlled by sysfs.
> > > > >=20
> > > >=20
> > > > A comment in pcie_config_aspm_link() says:
> > > >=20
> > > >   /* Enable only the states that were not explicitly disabled */
> > > >=20
> > > > But the function is called from both aspm_attr_store_common() and
> > > > __pci_enable_link_state(). So I don't know if this is behavior is i=
ntentional
> > > > or wrong.
> > >=20
> > > Hi,
> > >=20
> > > I think it's intentional. Whether the behavior is useful is another g=
ood
> > > question but the current behavior aligns with the explanation in the
> > > comment.
> > >=20
> > > My understanding of the situation is:
> > >=20
> > > pci_disable_link_state() and pci_enable_link_state() are not symmetri=
c
> > > despite the names, never have been (this is one of those many quirks =
ASPM
> > > driver has which should be eventually cleaned up, IMO).
> > >=20
> > > It might be appropriate to rename pci_enable_link_state() to
> > > pci_set_default_link_state() to match the name to its functionality (=
and
> > > the function comment):
> > >=20
> > >   * pci_enable_link_state - Clear and set the default device link sta=
te
> > >=20
> > > Note: "the default ... link state".
> > >=20
> > >=20
> > > I've already raised this concern earlier! As you see, my comment are
> > > not getting addressed. I'd like to see the author does one of these:
> >
> > I replied to your comment on v3 patch[1], and I feel instead of having
> > new function() we can use same API to our purpose.

It's not about what "feels" something. One should clearly write down why
such conversion is correct/acceptable when it comes to existing callers=20
if changing an existing API. The note should be such that it remains a=20
permanent record for future (in the changelog).

I don't have answer to what are the expectations or intent of the existing=
=20
callers. Convincing a patch is fine is responsibility of the one who is=20
submitting the patch, not reviewer's.

Unfortunately, it is usually quite hard to figure out for existing drivers=
=20
we're not familiar with. I'm not saying your "feel" is necessarily wrong,=
=20
but the existing callers need to be properly investigated if you choose=20
that path, not just handwaved over. It likely boils down if the=20
->aspm_default and controlling it are useful features to have in the ASPM=
=20
driver as your patch would take away that ability.

> You replied to Ilpo, but never got an agreement. Please try to close the
> discussions before posting next rev. If reviewers forgot to reply to your=
 query,
> feel free to ping them in the same thread itself.
>
> > > 1) Renames pci_enable_link_state() to pci_set_default_link_state()
> > >=20
> > > 1b) If pci_enable_link_state() is still needed after that, a new func=
tion
> > > is added to symmetrically pair with pci_disable_link_state().
> > >=20
> > > or alternatively,
> > >=20
> > > 2) Changelog justifies very clearly why this change is okay with the
> > > existing callers. (And obviously the function comment should be alter=
ed to
> > > match the functionality in that case too).
> > >=20
> > > If approach 2 is chosen, it should be very carefully reviewed when it
> > > comes to the callers.
> > >=20
> > I am in favor of approach 2 which you suggested, but lets wait for othe=
r
> > reviewers feedback on this. Based up on the response i will make
> > necessary changes in v5.
> >=20
>=20
> I would go for (1). It is always going to be a problem to change a legacy=
 API
> like this. We might end up causing regressions. So it is safe to rename t=
o
> reflect the purpose and try to come up with a new API that does what you =
want.
> If callers want to migrate to the new API, they can also do it in the fut=
ure.

That's my recommendation as well.

--=20
 i.
--8323328-1361302077-1752225289=:933--

