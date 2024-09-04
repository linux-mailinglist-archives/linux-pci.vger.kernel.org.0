Return-Path: <linux-pci+bounces-12784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9255396C7FC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 21:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC6C2875D8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 19:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F98F1E6DDB;
	Wed,  4 Sep 2024 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK5vt/ea"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C940C03;
	Wed,  4 Sep 2024 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479576; cv=none; b=bfqBtehiqLbL+EuW5j5Eq63KM/lpNufK3Hs9ORa03AubYhvta2MMnq4uGuYtbRrR6H/6sGBdVYzWdmPOTeq1ajKIR/AXEk27HH6QCrRhZHmzv7MDFJ6Ghxi48jqEsQb4A0FZ8TH8CmjtdFZ5fFOuMcfOmm2us6CxxSbBEiKsx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479576; c=relaxed/simple;
	bh=QCqDuPFMOBB4e5sBuCIluEU8xEtMSPJX7BvF8nmKxf8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J3jcWV0wbgIaoynJDT/jA+M2+fqAXoR0l1xuoJWwK5XbnFt+FAlhf6T/qCOxN7LIABkSy8ldQnALFTF/f+CQFTpgSb1yHrpLR6rIU9f6QD6DhO2u1qKiSoYJt5lmL1GttzGzlHhQ+0LanzhI6ll10Bb3DiWDxsKxTljjr4vKXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK5vt/ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB645C4CEC2;
	Wed,  4 Sep 2024 19:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725479576;
	bh=QCqDuPFMOBB4e5sBuCIluEU8xEtMSPJX7BvF8nmKxf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eK5vt/ea7mMUrfVBREvVMg0CPjEmdbZdKS6E0W2xomgKf6ixkOGrYlUEs5pBMP9oP
	 t2NKEeqUMA77swQ8Fcjd1aKk2H80icZGU8ZdjKHRdf588A0utFNZiHh0CIB2qZsyxs
	 A+PnCBRzRE9ivFDo0bjspnrO4kLYgcHIqep9ZBp6/SOccbQI/0qbToiER8FFjYxKUM
	 kZrGZ7UmCQMJ9x7bLALot6OMN22ROhJR0Nwe8w2Wj2pyui/fbx6IbzfHhvT+2gYm4w
	 z221tMFIXFnjNfuYCl/mSWhtaG9SeCvtoubN+hlfp247Yjbl3EDePcg+WtByZ011IV
	 vZxjTw9sebRkg==
Date: Wed, 4 Sep 2024 14:52:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V4 02/12] PCI: Add TPH related register definition
Message-ID: <20240904195254.GA344807@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822204120.3634-3-wei.huang2@amd.com>

On Thu, Aug 22, 2024 at 03:41:10PM -0500, Wei Huang wrote:
> Linux has some basic, but incomplete, definition for the TPH Requester
> capability registers. Also the definitions of TPH Requester control
> register and TPH Completer capability, as well as the ST fields of
> MSI-X entry, are missing. Add all required definitions to support TPH
> without changing the existing Linux UAPI.

>  /* TPH Requester */
>  #define PCI_TPH_CAP		4	/* capability register */
> -#define  PCI_TPH_CAP_LOC_MASK	0x600	/* location mask */
> -#define   PCI_TPH_LOC_NONE	0x000	/* no location */
> -#define   PCI_TPH_LOC_CAP	0x200	/* in capability */
> -#define   PCI_TPH_LOC_MSIX	0x400	/* in MSI-X */
> -#define PCI_TPH_CAP_ST_MASK	0x07FF0000	/* ST table mask */
> -#define PCI_TPH_CAP_ST_SHIFT	16	/* ST table shift */
> -#define PCI_TPH_BASE_SIZEOF	0xc	/* size with no ST table */
> +#define  PCI_TPH_CAP_NO_ST	0x00000001 /* No ST Mode Supported */
> +#define  PCI_TPH_CAP_INT_VEC	0x00000002 /* Interrupt Vector Mode Supported */
> +#define  PCI_TPH_CAP_DEV_SPEC	0x00000004 /* Device Specific Mode Supported */

I think these modes should all include "ST" to clearly delineate
Steering Tags from the Processing Hints.  E.g.,

  PCI_TPH_CAP_ST_NO_ST       or maybe PCI_TPH_CAP_ST_NONE
  PCI_TPH_CAP_ST_INT_VEC
  PCI_TPH_CAP_ST_DEV_SPEC

> +#define  PCI_TPH_CAP_EXT_TPH	0x00000100 /* Ext TPH Requester Supported */
> +#define  PCI_TPH_CAP_LOC_MASK	0x00000600 /* ST Table Location */
> +#define   PCI_TPH_LOC_NONE	0x00000000 /* Not present */
> +#define   PCI_TPH_LOC_CAP	0x00000200 /* In capability */
> +#define   PCI_TPH_LOC_MSIX	0x00000400 /* In MSI-X */

These are existing symbols just being tidied, so can't really add "ST"
here unless we just add aliases.  Since they're just used internally,
not by drivers, I think they're fine as-is.

> +#define  PCI_TPH_CAP_ST_MASK	0x07FF0000 /* ST Table Size */
> +#define  PCI_TPH_CAP_ST_SHIFT	16	/* ST Table Size shift */
> +#define PCI_TPH_BASE_SIZEOF	0xc	/* Size with no ST table */
> +
> +#define PCI_TPH_CTRL		8	/* control register */
> +#define  PCI_TPH_CTRL_MODE_SEL_MASK	0x00000007 /* ST Mode Select */
> +#define   PCI_TPH_NO_ST_MODE		0x0 /* No ST Mode */
> +#define   PCI_TPH_INT_VEC_MODE		0x1 /* Interrupt Vector Mode */
> +#define   PCI_TPH_DEV_SPEC_MODE		0x2 /* Device Specific Mode */

These are also internal, but they're new and I think they should also
include "ST" to match the CAP #defines.

Even better, maybe we only add these and use them for both CAP and
CTRL since they're defined with identical values.

