Return-Path: <linux-pci+bounces-371-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC688016D6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 23:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D6CFB20BF8
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 22:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488521A18;
	Fri,  1 Dec 2023 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx1uGmM9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D69619AF
	for <linux-pci@vger.kernel.org>; Fri,  1 Dec 2023 22:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7810CC433C7;
	Fri,  1 Dec 2023 22:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701470758;
	bh=mCohPRAX+vrdHwTJQfgkUwLwKKdD+fr/q27He1nuF8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Kx1uGmM9g+AIj3wuXBYWMCmQc9JPLjuznc9FaYjduL06/UxSMwuS8ZN7X/yHVTnCD
	 WokxVBc+afmbzOK1IXvBwaMbSVcetA7WC9BhkiWjLVefqDhR0ZvnFcHEuGe35jQf+S
	 IURMlnW9WmH++LEenQOz1HU4fVh+/NNVMDiUhUbaMuSnshQFxjVNqH8bRpJmEzSHCs
	 4centAtD1uaulNfuu66PXGaTzLujuEVPIHiiUWoQoVYRqje9rTG2+ko6aF+23nvHhc
	 nBTVHL8ZeulJ9judD0RjvheDiMGblkuL0zhKYgCKdTmvz7lzc5o7Auh2O/ZjzVyZsa
	 dHxqFZTpv1WmQ==
Date: Fri, 1 Dec 2023 16:45:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	Max Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	PCI <linux-pci@vger.kernel.org>,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
Message-ID: <20231201224556.GA534342@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJvt6FpXK+FgAwE8xN3G5Z23Ktq=SEY-K7VA7nM5XgZRg@mail.gmail.com>

On Fri, Dec 01, 2023 at 04:26:45PM -0600, Rob Herring wrote:
> On Thu, Nov 30, 2023 at 10:57 AM Herve Codina <herve.codina@bootlin.com> wrote:
> ...

> Also, no idea if the bridge part works because my qemu setup doesn't
> create bridges (anyone got a magic cmdline to create them?).

I probably copied this from somewhere and certainly couldn't construct
it from scratch, but it did create a hierarchy like this:

  00:04.0 bridge to [bus 01-04] (Root Port)
  01:00.0 bridge to [bus 02-04] (Switch Upstream Port)
  02:00.0 bridge to [bus 03] (Switch Downstream Port)
  02:01.0 bridge to [bus 04] (Switch Downstream Port)
  03:00.0 endpoint
  04:00.0 endpoint

  IMAGE=ubuntu.img
  KERNEL=~/linux/arch/x86/boot/bzImage
  IMGDIR=~/virt/img/

  qemu-system-x86_64 -enable-kvm -s -m 2048 $IMAGE \
      -device pcie-root-port,id=root_port1,chassis=1,slot=1 \
      -device x3130-upstream,id=upstream_port1,bus=root_port1 \
      -device xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=2,slot=1 \
      -device xio3130-downstream,id=downstream_port2,bus=upstream_port1,chassis=2,slot=2 \
      -drive file=${IMGDIR}/nvme.qcow2,if=none,id=nvme1,snapshot=on \
      -device nvme,drive=nvme1,serial=nvme1,cmb_size_mb=2048,bus=downstream_port1 \
      -drive file=${IMGDIR}/nvme2.qcow2,if=none,id=nvme2,snapshot=on \
      -device nvme,drive=nvme2,serial=nvme1,bus=downstream_port2 \
      -virtfs local,id=home,path=/home/,security_model=mapped,mount_tag=home \
      -nographic \
      -kernel $KERNEL \
      -append "root=/dev/sda2 rootfstype=ext4 console=ttyS0,38400n8"

