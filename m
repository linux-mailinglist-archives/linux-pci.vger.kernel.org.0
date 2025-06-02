Return-Path: <linux-pci+bounces-28823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0C9ACBB4B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 20:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D505517505B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547B22331C;
	Mon,  2 Jun 2025 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giDb07Om"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC4D9478
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 18:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748890700; cv=none; b=OFku2TRSl7oNXkf9E1GpmsrQTdLolt2zg84SGOv5p6QjNabbZYfpxxW0Bc/8UBNj15qNYiiM9VssRrPm+486rTdAk5Pzn7UiY5cX/yDbs0EsMTyLhHKbSyr1PFNfgDbkLGur0bvRrfEEuowWqqzcOJiJpAWU1p6JwdYQNkSO5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748890700; c=relaxed/simple;
	bh=v2x3I7vJUp8Nn4sz3nlD9/N+0W37+LyoFXHCrYC2P3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPkWldWc4n3Cl9UvFf7c9pNnf2dWRv5QDc3Nqi8FLWDkCk1wQ9Vz4wG/x7NHgGJDBDBCNcBpkOV+yENnogiiGDe7hn4Bz8Ne5yz5uvVh8Z3B9XPJSvepr/s1GyAhIVCrtyI/eNpO1i7SRaEQofG6+Hy2/2gfAp5KN/lVijCvny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giDb07Om; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748890699; x=1780426699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v2x3I7vJUp8Nn4sz3nlD9/N+0W37+LyoFXHCrYC2P3U=;
  b=giDb07Om84Hu4BokRQY1Xb2g/OJNefgHcZl9Soyoo+PuVl6F4FRYKhvP
   LdA/+hNlKolTJI/9Co2dz1c4wViVg18i+tzh6QiMelg7pPsdYQJJbNEEE
   gL9jYFfDn3E6iRqlw5KuW0kXFX7VemCpqtDLzcbBEV7hn/ns/S/vHUaYs
   BUEf8GiFBYjdC99VRKZM3MJ2TGzyikVVbnrN6YUNAYflQlBx/v4dM0QyS
   7hMmas7TKKgJ8IiWlrRHNheWCS0m0yRhxtQypXxK8iXX+SnIflL+Cduih
   1bfnCVIQlEDicMFKp4BieGN/Vcww30WWop+glXMYMgq9dW1o9sf3NUwmn
   w==;
X-CSE-ConnectionGUID: CjQ1R+AdRL239qElNncuJA==
X-CSE-MsgGUID: 4h2lii7fRMW2SH7roCPOrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="53537158"
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="53537158"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 11:58:18 -0700
X-CSE-ConnectionGUID: HTfw4oFzRVe13jt5NYBKKg==
X-CSE-MsgGUID: St/FPc1BSvmxKKoSe/ONGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,204,1744095600"; 
   d="scan'208";a="145556404"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 02 Jun 2025 11:58:15 -0700
Date: Tue, 3 Jun 2025 02:51:44 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
	sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <aD3ywEQuFMIEng8T@yilunxu-OptiPlex-7050>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
 <682ce21c17363_1626e1004e@dwillia2-xfh.jf.intel.com.notmuch>
 <aC2c1SggkqKSO1st@yilunxu-OptiPlex-7050>
 <2fb2de7a-efc2-4ab0-8303-833dd2471d9f@amd.com>
 <aDhtLn2ySm/pgeab@yilunxu-OptiPlex-7050>
 <4b3621d7-4bed-44c7-8139-57de5825e968@amd.com>
 <aDsfmJpUqy53dans@yilunxu-OptiPlex-7050>
 <80277929-ce8d-4cef-98ed-c5280fdfa543@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80277929-ce8d-4cef-98ed-c5280fdfa543@amd.com>

On Mon, Jun 02, 2025 at 02:51:53PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 1/6/25 01:26, Xu Yilun wrote:
> > On Fri, May 30, 2025 at 12:54:44PM +1000, Alexey Kardashevskiy wrote:
> > > 
> > > 
> > > On 30/5/25 00:20, Xu Yilun wrote:
> > > > > > > 
> > > > > > > > > + * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
> > > > > > > > > + * @type: identify the format of the following blobs
> > > > > > > > > + * @type_info: extra input/output info, e.g. firmware error code
> > > > > > > > 
> > > > > > > > Call it "fw_ret"?
> > > > > > > 
> > > > > > > Sure.
> > > > > > 
> > > > > > This field is intended for out-of-blob values, like fw_ret. But fw_ret
> > > > > > is specified in GHCB and is vendor specific. Other vendors may also
> > > > > > have different values of this kind.
> > > > > > 
> > > > > > So I intend to gather these out-of-blob values in type_info, like:
> > > > > > 
> > > > > > enum pci_tsm_guest_req_type {
> > > > > >      PCI_TSM_GUEST_REQ_TDXC,
> > > > > >      PCI_TSM_GUEST_REQ_SEV_SNP,
> > > > > > };
> > > > > 
> > > > > 
> > > > > The pci_tsm_ops hooks already know what they are - SEV or TDX.
> > > > 
> > > > I think this is for type safe check to some extend. The tsm driver hook
> > > > assumes the blobs are for its known format, but userspace may pass in
> > > > another format ...
> > > 
> > > The blobs are guest_request blobs, they enter the kernel via iommufd's viommu ioctl and viommu already has  iommu_viommu_type which is (in my tree):
> > > 
> > > enum iommu_viommu_type {
> > >          IOMMU_VIOMMU_TYPE_DEFAULT = 0,
> > >          IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
> > >         IOMMU_VIOMMU_TYPE_AMD_TSM = 2,
> > >         IOMMU_VIOMMU_TYPE_AMD = 3,
> > >   };
> > 
> > That's a good point. So I think we don't have to use a 'type' field for
> > ioctl(IOMMUFD_VDEVICE_GUEST_REQUEST). But I didn't see these viommu_type
> > would be passed to TSM driver.So for this pci_tsm_guest_req kAPI, is it
> > still good we keep the 'type' for type safe check in TSM driver?
> This means that we somehow make it possible to create an Intel vdevice for the AMD TSM and now have to catch such situation  in runtime which seems wrong, we should not allow the mix in the first place. IOMMUFD is going to call the platform IOMMU code and that guy will just refuse creating a wrong viommu type.

That's good point, seems we should check if viommu type matches TSM ...
Need more investigations on it

> 
> 
> > > 
> > > > > 
> > > > > 
> > > > > > /* SEV SNP guest request type info */
> > > > > > struct pci_tsm_guest_req_sev_snp {
> > > > > > 	s32 fw_err;
> > > > > > };
> > > > > > 
> > > > > > Since IOMMUFD has the userspace entry, maybe these definitions should be
> > > > > > moved to include/uapi/linux/iommufd.h.
> > > > > > 
> > > > > > In pci-tsm.h, just define:
> > > > > > 
> > > > > > struct pci_tsm_guest_req_info {
> > > > > > 	u32 type;
> > > > > > 	void __user *type_info;
> > > > > > 	size_t type_info_len;
> > > > > > 	void __user *req;
> > > > > > 	size_t req_len;
> > > > > > 	void __user *resp;
> > > > > > 	size_t resp_len;
> > > > > > };
> > > > > > 
> > > > > > BTW: TDX Connect has no out-of-blob value, so should set type_info_len = 0
> > > > > 
> > > > > 
> > > > > No TDX Connect fw error handling on the host OS whatsoever, always return to the guest?
> > > > 
> > > > Always return to guest. The fw error info (not raw fw error code) is
> > > > embedded in response blob.
> > > > 
> > > > For QEMU/IOMMUFD, Guest Request doesn't care blob data, so don't have
> > > > to judge fw_error either. Alway return to the guest and let the guest
> > > > decide what to do.
> > > 
> > > So whatever is inside such requests, the host is not told about it ever? How does DOE bouncing work on Intel then if the fw cannot ask the host to do DOE? Thanks,
> > > 
> > 
> > No, I just say QEMU/IOMMUFD don't care about the execution, so no need
> > an explicit fw_err return to them. Platform TSM driver should definitely
> > know about fw_err and handle it (to do DOE or anything else) internally,
> > but don't have to EXPLICITLY propagate these error code to up layers (TSM
> > core/QEMU/IOMMUFD).
> 
> On AMD, the host has to provide certain handles along with the guest request/response buffers and the host can get it wrong so the host may want to know if the host did a wrong call. Say, we are killing a guest and by the same time making a guest request - will the Intel fw still say "that's ok, forward the response to the guest", even if it knows it is not possible?

For Intel, there is no 'guest_request' fw_call. Every GHCI call has
clear meaning to host (TSM driver) and host uses exact fw_calls to
complete each GHCI call.

Intel fw doesn't fill GHCI buffer, it just executes fw_call and
returns fw_err to host. Intel fw will not decide forwarding anything to
guest or not. It is the TSM driver's job to fill GHCI buffer according
to fw_call execution status.

That said, guest_request is just a QEMU selected set of GHCI commands.

For guest_request, a GHCI OK only means host has filled the response
buffer, host fills fw_err to the response buffer and guest should look
into the response buffer to see what really happened.

> Or SPDM session broke - the host OS won't be told until it specifically make a call other than guest request? Seems weird but okay. Thanks,
> 

The TDX TSM driver knows every detail of the execution of a fw_calls.

Thanks,
Yilun

> 
> > Thanks,
> > Yilun
> > 
> > > > > oookay, do not use it but the fw response is still a generic thing. Whatever is specific to AMD can be packed into req/resp and QEMU/guest will handle those.
> > > > 
> > > > But for out-of-blob data, it is the same effort as packing into type_info.
> > > > At least we could have a clear idea, which blob is SW defined, which blob
> > > > is GHCI/GHCB defined.
> > > > 
> > > > Thanks,
> > > > Yilun
> > > 
> > > -- 
> > > Alexey
> > > 
> 
> -- 
> Alexey
> 
> 

