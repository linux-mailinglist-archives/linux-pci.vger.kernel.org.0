Return-Path: <linux-pci+bounces-37479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8EBB58B3
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 00:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB913A7D12
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C65128371;
	Thu,  2 Oct 2025 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcNcVw2b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF42F2D
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444236; cv=none; b=gu9qyWGB22JijijULLlQgghTNZxC89heSFPfUDJuXZOOtKGA9ujZW2SzmaXpAa/PdaECEuTBlWcrFwY43mZnQxRwc4UG2mB5j6MoL87Z36IqgYZ/rb6S+GVK+QrxZZciC5kmdQI4P1I+mkXY63hy3FZtVC320hKXTU3TcYmmsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444236; c=relaxed/simple;
	bh=mclwb4BLPmCejXVZg2cR82rxkFBq0yH1/DlDBXyjY74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtFb9jh+7kcS2bQ8y7qRARJtt+tJJNhnwIeVy2qBeo1XPj3d/jvlrFkXs3mfPjfRUixw2UDgZO0wnjUSC9XVZaGrHvDO7ClQWO/Loj93Fh7K99drJAPNomH3osRTudLEKOTE8gexjHx+SYuw9xdVhK7JI4JIpBtVNDq8jO2/M7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcNcVw2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E59C113D0
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 22:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759444235;
	bh=mclwb4BLPmCejXVZg2cR82rxkFBq0yH1/DlDBXyjY74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZcNcVw2bBfizYT3syecFR74oq8jg0ZM0QoFIkNJhekVil48dSD9CJOrHTQe+UXGZS
	 XyukVruIMo55D3gW2VGpMca6347oLdOIOjpmN3RQA1CLvzAsQr0+k7fC2pWFFrYPEq
	 UuCZMqIzlhEQQ0xJKxIRb169HgxbNTyyQL3Pfh9A9Yt3qnrl+Gx7K9jJBM8qV41RDN
	 gwGPbRa6KOAZkTxnk8APDEz2mGcnQPLs9PrBzjkUi76E847gXDUr+GbHfZ7Bpwy9IC
	 PkcHdQRyg6bMRVadQFk4/LxaRJmADo0csj8EdYKzT1R3jlLyQ7yBh5ErbDM6qvphxF
	 Xo1ypXm6IGgaw==
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6353f2937f3so1704443d50.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 15:30:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFFJ3fE5UtbUIElJZ0Y8+Amr5oZvzQwNRFVzvhb+fda/SUCevMHXTPMLODrYmvU11xtbED/gU+Lkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3eRK/JN1MajljnZD5ZwROk+EQbF8qTc57leT1BmCb2HMswQe6
	L8rzUn5GUtDX5f3o9AokjD9YH30TMDv01vHhSTbgVRd6PGT7/76kT2H6xdLcUovHv7BX6ijPQo8
	BLkMQ74HlrdKoCUNe74U5NiBWJBTZFZMPkQ8zHhYYkA==
X-Google-Smtp-Source: AGHT+IER8jPAUzVQN0o6Ky1MS7KVMc0a4lSY1AA2ChRrKcHMDDcDaZNsOD3pjWILpiKV4YkdhpOWKKWWlyCIVXeH7GA=
X-Received: by 2002:a05:690e:2513:20b0:5f4:55cb:80d4 with SMTP id
 956f58d0204a3-63b9a074d1emr857849d50.17.1759444235020; Thu, 02 Oct 2025
 15:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-6-c494053c3c08@kernel.org>
 <20250929175704.GK2695987@ziepe.ca> <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <2025093030-shrewdly-defiant-1f3e@gregkh> <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>
 <2025093052-resupply-unmixable-e9bb@gregkh> <CA+CK2bCBFZDsaEywbfCzDJrH3oXyMmSffV-x7bOs8qC7NT7nAg@mail.gmail.com>
 <2025100147-scrubbed-untold-fc55@gregkh> <CA+CK2bA0acjg-CEKufERu_ov4up3E4XTkJ6kbEDCny0iASrFVQ@mail.gmail.com>
 <2025100225-abridge-shifty-3d50@gregkh>
In-Reply-To: <2025100225-abridge-shifty-3d50@gregkh>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 2 Oct 2025 15:30:24 -0700
X-Gmail-Original-Message-ID: <CACePvbWw9G=y_cycWFMXxRbmuAE8yFCM0Z3y=Ojw30ENDkDL-g@mail.gmail.com>
X-Gm-Features: AS18NWBKklIiW19M0HLe-eu5UU3jj0bpgI_sv1S6en5UzgvXxCD0FefovaS2CF8
Message-ID: <CACePvbWw9G=y_cycWFMXxRbmuAE8yFCM0Z3y=Ojw30ENDkDL-g@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 11:09=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Just keeping a device "alive" while rebooting into the same exact kernel
> image seems odd to me given that this is almost never what people
> actually do.  They update their kernel with the weekly stable release to
> get the new bugfixes (remember we fix 13 CVEs a day), and away you go.
> You are saying that this workload would not actually be supported, so
> why do you want live update at all?  Who needs this?

I saw Pasha reply to a lot of your questions. I can take a stab on who
needs it. Others feel free to add/correct me. The major cloud vendor
(you know who is the usual suspect) providing GPU to the VM will want
it. The usage case is that the VM is controlled by the customer. The
cloud provider has a contract on how many maintenance downtimes to the
VM. Let's say X second maintenance downtime per year. When upgrading
the host kernel, typically the VM can be migrated to another host
without much interruption, so it does not take much from the down time
budget. However when you have a GPU attached to the VM, the GPU is
running some ML jobs, there is no good way to migrate that GPU context
to another machine. Instead, we can do a liveupdate from the host
kernel. During the liveupdate, the old kernel saves the liveupdate
state. VM is paused to memory while the GPU as a PCI device is kept on
running.  ML jobs are still up.  The kernel liveupdate kexec to the
new kernel version. Restore and reconstruct the software side of the
device state. VM re-attached to the file descriptor to get the
previous context. In the end the VM can resume running with the new
kernel while the GPU keeps running the ML job. From the VM point of
view, there are Y seconds the VM does not respond during the kexec.
The GPU did not lose the context and VM did not reboot. The benefit is
that Y second is much smaller than the time to reboot the VM  and
restart the GPU ML jobs. So that Y can fit into the X second
maintenance downtime per year in the service contract.

Hope that explanation makes sense to you.

Chris

