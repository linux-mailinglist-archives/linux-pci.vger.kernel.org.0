Return-Path: <linux-pci+bounces-22797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56858A4CEAB
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 23:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79042189119E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 22:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F83F1EFFA9;
	Mon,  3 Mar 2025 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgbsxoNu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B507EC4;
	Mon,  3 Mar 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041992; cv=none; b=fOfMsgL2OBNuunWy2jYwjw6yzWWJiN0imCJATE3eD30i8RwVqdPXog7uzYYZw9gh7WzaGi9CRbnm8lVewZiMwRvyBsKPZGf8Q1TGClTmRGrxfLYd1ElR3f5ajKrfhZgAir77IGY6pIxzpIWnh/hHgdXFpFVjKOkwUUfzfOX26wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041992; c=relaxed/simple;
	bh=1+001NeYazMZQw+vBYsBEOI1qWzgABI/0Tno7peEKf8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G5wg2b6qsdiB6C5GYObHUfl7qiK5miN8qZM37WivugWi/llDETaC954HImz7W72BeDLhgg5uaVl9iVrJYkyQoQO4VYj2p/WmYAxSQvBcPD7mKKudy79sgC6g2Zojbhw3XJ9XW/rsLvwYnKuUVTtXHK492ji01Fa8McilXp8FYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgbsxoNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96CCC4CED6;
	Mon,  3 Mar 2025 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741041991;
	bh=1+001NeYazMZQw+vBYsBEOI1qWzgABI/0Tno7peEKf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KgbsxoNus15PD3JZK15+LLH+uySL8KLyTa0EmhRqt1HVvacCzep5IrgCurkYy4FoY
	 1DNNdU1XqYk4pzIwqMloGneaoXbzNwqTXWF1OWoz2q/hdMzSzpb1GccWCulFEdZ7Ld
	 01S97hksDMOfJdZeBqWGsIaj6LCewxViHr8a6rhSHin8/HRMxsFQo6vTOQOqAUwEm2
	 3ezvJK+ZxabF0u6p3TFORj3aRfc9gMemASOoPbljokUwagztHCnWsNh3Ll58CVFjDj
	 ZldKvx2L4Ie3fHoLwPgGyRrpwpKIO2IDfyTc2oVC9Y27EdQudVPmWMm8wEa11wlFt1
	 jrv3MxJiiyIQA==
Date: Mon, 3 Mar 2025 16:46:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: bhelgaas@google.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rafael@kernel.org
Subject: Re: Re: [PATCHv4] PCI/ACPI: _DSM PRESERVE_BOOT_CONFIG function rev
 id doesn't match with spec
Message-ID: <20250303224630.GA204751@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301032822.17486-1-zhoushengqing@ttyinfo.com>

On Sat, Mar 01, 2025 at 03:28:22AM +0000, Zhou Shengqing wrote:
> On Thu, Feb 27, 2025 at 6:40 PM Bjorn Helgaas wrote:
> > On Mon, Dec 16, 2024 at 05:27:51AM +0000, Zhou Shengqing wrote:
> > > Per PCI Firmware Specification Revision 3.3 Table 4-7 _DSM Definitions
> > > for PCI. Preserve PCI Boot Configuration Initial Revision ID changed to 2.
> > > But the code remains unchanged, still 1.
> > > 
> > > v4:Initialize *obj to NULL.
> > > v3:try revision id 1 first, then try revision id 2.
> > > v2:add Fixes tag.
> > 
> > Thanks for working on this issue.
> > 
> >   - Thanks for the revision history.  For future posts, put it below
> >     the "---" line so it's in the email but not part of the commit log.
> > 
> >   - I think there's a leak in pci_acpi_preserve_config() because it
> >     doesn't free "obj" before it returns true.  If you agree, add a
> >     preparatory patch to fix this.
> > 
> >   - Add a preparatory patch to return false early in
> >     pci_acpi_preserve_config() if !ACPI_HANDLE(&host_bridge->dev) so
> >     the body of the function is unindented, similar to what
> >     acpi_pci_add_bus() does.
> > 
> >   - Add another preparatory patch that adds acpi_check_dsm() of the
> >     desired function/rev ID for DSM_PCI_PRESERVE_BOOT_CONFIG,
> >     DSM_PCI_POWER_ON_RESET_DELAY, DSM_PCI_DEVICE_READINESS_DURATIONS.
> >     Move the "Evaluate PCI Boot Configuration" comment above the
> >     acpi_check_dsm() since it applies to the whole function, not just
> >     the rev 1 code in this patch.
> > 
> >   - Rework this patch so it only adds acpi_check_dsm() and
> >     acpi_evaluate_dsm_typed() for rev 2.
> 
> Could you please explain this in more detail? Do you mean we don't need to
> consider rev 1 anymore?

No, I think we still need to handle platforms that implemented PCI
Firmware spec r3.2 and used rev 1.

Platforms that implemented spec r3.3 probably use rev 2, and we don't
know whether they support rev 1.

So I think the ultimate function would look something like this:

  bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
  {
      bool rc = false;

      if (!ACPI_HANDLE(&host_bridge->dev))
	  return false;

      if (acpi_check_dsm(..., 1, BIT(DSM_PCI_PRESERVE_BOOT_CONFIG))) {
	  obj = acpi_evaluate_dsm_typed(..., 1, DSM_PCI_PRESERVE_BOOT_CONFIG, ...);
	  if (obj && obj->integer.value == 0)
	      rc = true;
	  ACPI_FREE(obj);
      } else if (acpi_check_dsm(..., 2, BIT(DSM_PCI_PRESERVE_BOOT_CONFIG))) {
	  obj = acpi_evaluate_dsm_typed(..., 2, DSM_PCI_PRESERVE_BOOT_CONFIG, ...);
	  if (obj && obj->integer.value == 0)
	      rc = true;
	    ACPI_FREE(obj);
      }

      return rc;
  }

