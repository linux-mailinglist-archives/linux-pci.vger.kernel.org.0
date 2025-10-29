Return-Path: <linux-pci+bounces-39692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11DC1C68A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AFD54E2818
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705B2E54CC;
	Wed, 29 Oct 2025 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2oZiAzj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19582F5478;
	Wed, 29 Oct 2025 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758145; cv=none; b=XZlFIJv6cKDcbZF+PgSBcKdzU0mUtMwuYF6Wzxf0tfEjxm8dskQFiG2qLnFtFMKEI1KJqHSh7hABV8LBHHzFdj8vtSX2Xl2lzsye9yXAJTi7LhTqKIg9DayzoNVERyusu2sANJcpotsMv7O9OBp9nukubG3AIV1daldyYIoXuaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758145; c=relaxed/simple;
	bh=aTH9RDC1w35QI+C/9O3+e03r8SlUEnN2DLEh1omTVxI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p3u+Auvwe+RzNjKYmZfnuqAcIsSUs9U+4L3/HrnDmlSvRDGjL0gbj/L+xwTKsP591k8GTVmoWqWtZSTrgCp1645YXrG0oPuq9pCdLfMgeRLSWuXWL+y1CDmB3m2DdTjQKfblu6grqOftbQg7twYDOVbd1iTB4yda2f0/ccLrhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2oZiAzj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30EC1C4CEF7;
	Wed, 29 Oct 2025 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761758144;
	bh=aTH9RDC1w35QI+C/9O3+e03r8SlUEnN2DLEh1omTVxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F2oZiAzjXdNtAUAsY1CEl4tAmlmMYBM57LRusTm3JP84ay1DL5gLI7lJPQ7K+XZQw
	 POEnGzxvyeFJ7xFVORqOgxtbSP+rx6ffyYYVBjVHZtLvwAaQONKIJC45059WM/mKKB
	 voJM7vXDvA6piO/VKqu23xRA/HWr6AAVrbA0C0ZDMsMAkx+rqfXm9MjOyllwSYETpz
	 Q9P3n7ZZU5+azSb0hYgBixCfAYXTeFGzBh6z3vW2t4G1ESVuN+37mW0+75VqVu8ZYn
	 8oE/VV/5JMnFZ5IJBIngDjGzOujg3XGHhwmmhkNorZrvtDEE0Hfcaa+kHsAqm7SAO3
	 hvAWDiH4yehqg==
Date: Wed, 29 Oct 2025 12:15:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linnaea Lavia <linnaea-von-lavia@live.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
Message-ID: <20251029171542.GA1566240@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR05MB1027063F8AA9069B66A632C2EC7FAA@DM4PR05MB10270.namprd05.prod.outlook.com>

On Wed, Oct 29, 2025 at 06:50:46PM +0800, Linnaea Lavia wrote:
> On 10/29/2025 6:16 AM, Bjorn Helgaas wrote:

> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 214ed060ca1b..9cd12924b5cb 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
> >    * disable both L0s and L1 for now to be safe.
> >    */
> >   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
> >   /*
> >    * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
> 
> I have applied the patch on 6.18-rc3 but it's still trying to enable ASPM for some reasons.

Sorry, my fault, I should have made that fixup run earlier, so the
patch should be this instead:

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..4fc04015ca0c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
  * disable both L0s and L1 for now to be safe.
  */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);

