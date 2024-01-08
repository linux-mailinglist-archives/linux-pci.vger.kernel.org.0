Return-Path: <linux-pci+bounces-1817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCFF8270E4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6F61F22E20
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636445C08;
	Mon,  8 Jan 2024 14:19:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C347775;
	Mon,  8 Jan 2024 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 8267530000D0D;
	Mon,  8 Jan 2024 15:19:01 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 65AA919453; Mon,  8 Jan 2024 15:19:01 +0100 (CET)
Date: Mon, 8 Jan 2024 15:19:01 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com, treding@nvidia.com,
	jonathanh@nvidia.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, vsethi@nvidia.com, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: pciehp: Disable ACS Source Validation during
 hot-remove
Message-ID: <20240108141901.GA17779@wunner.de>
References: <20230111190533.29979-1-vidyas@nvidia.com>
 <20230730191519.3124390-1-vidyas@nvidia.com>
 <20230730194026.GA19962@wunner.de>
 <7880aa6e-9fc5-c026-138f-42bef3c48b69@nvidia.com>
 <20230731195930.GA13000@wunner.de>
 <f7324ca4-2c57-459c-a9e8-aac09ba65e87@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7324ca4-2c57-459c-a9e8-aac09ba65e87@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jan 04, 2024 at 08:01:06PM +0530, Vidya Sagar wrote:
> On 8/1/2023 1:29 AM, Lukas Wunner wrote:
> > As an alternative to disabling ACS, have you explored masking ACS
> > Violations (PCI_ERR_UNC_ACSV) upon de-enumeration of a device and
> > unmasking them after assignment of a bus number?
> 
> I explored this option and it seemed to work as expected. But, the issue
> is that this works only if the AER registers are owned by the OS. If the
> AER registers are owned by the firmware (i.e. Firmware-First approach of
> handling the errors), OS is not supposed to access the AER registers and
> there is no indication from the OS to the firmware as to when the
> enumeration is completed and time is apt to unmask the ACSViolation
> errors in the AER's Uncorrectable Error Mask register.
> Any thoughts on accommodating the Firmware-First approach also?

Are you actually using firmware-controlled AER or is it a theoretical
question?

PCI Firmware Spec r3.3 sec 4.6.12 talks about a _DSM to disable DPC
on surprise-hotplug-capable ports.  Maybe that would be an option?

BTW what happens if the system resumes from sleep and a device in
a hotplug-capable port doesn't have a bus number configured yet
(because it's been powered off and is now in D0uninitialized state)?
Could the ACS Violations then occur as well?  Do we have to mask
ACS Violations *generally* on Root Ports and Downstream Ports when
going to system sleep and unmask them after setting a bus number
in the attached device on resume?  And I suppose that would not
only be necessary for hotplug ports?

Thanks,

Lukas

