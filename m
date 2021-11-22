Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F014594E6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 19:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhKVSr1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 13:47:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239598AbhKVSr1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 13:47:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8B5060D42;
        Mon, 22 Nov 2021 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637606660;
        bh=smQupKCLw4/7NyflTJNZhsEQw8ICgUvAHXrWnYkvtNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qAWaN6VG1TF9wBTDARQQGJZFdwbHRQ2z22UHorEWJgwqoUzoUQhECHHQH4ieIuCv9
         1CvgyrhG0yPgX9ohhaMVJ87Y3eMXxi2kQMN0Fn6osEj5nw4a+M8BwaIyCWfADdLudF
         7eZ6caPQeP4AEWRC99Lp3ABkIm88a98ar0lyPhVdoHdiW2o1vE/r1H/v2lF+77kZcR
         WkqmR0lHOxIjE34MHRl5UOgjZ5S/mQbyS68WV1UdGbGPhyCLqSdrL7c0PNP5S05+9f
         cGA8ncUpFK9jr6uoHPRDzjqwSk5cmmciQ4cX6Qc0fPzo4gY1S6DzWdcmO/QX8OMtiy
         aXTWSna3GibcA==
Date:   Mon, 22 Nov 2021 12:44:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <20211122184418.GA2159461@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120231705.189969-5-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 20, 2021 at 03:17:05PM -0800, David E. Box wrote:
> Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> activating additional silicon features. Features are enabled through a
> license activation process.  The SDSi driver provides a per socket, sysfs
> attribute interface for applications to perform 3 main provisioning
> functions:
> 
> 1. Provision an Authentication Key Certificate (AKC), a key written to
>    internal NVRAM that is used to authenticate a capability specific
>    activation payload.
> 
> 2. Provision a Capability Activation Payload (CAP), a token authenticated
>    using the AKC and applied to the CPU configuration to activate a new
>    feature.
> 
> 3. Read the SDSi State Certificate, containing the CPU configuration
>    state.
> 
> The operations perform function specific mailbox commands that forward the
> requests to SDSi hardware to perform authentication of the payloads and
> enable the silicon configuration (to be made available after power
> cycling).
> 
> The SDSi device itself is enumerated as an auxiliary device from the
> intel_vsec driver and as such has a build dependency on CONFIG_INTEL_VSEC.
> 
> Link: https://github.com/intel/intel-sdsi
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Mark Gross <markgross@kernel.org>
> ---
>  .../ABI/testing/sysfs-driver-intel_sdsi       |  75 +++
>  MAINTAINERS                                   |   5 +
>  drivers/platform/x86/intel/Kconfig            |  12 +
>  drivers/platform/x86/intel/Makefile           |   2 +
>  drivers/platform/x86/intel/sdsi.c             | 571 ++++++++++++++++++
>  drivers/platform/x86/intel/vsec.c             |  12 +-
>  6 files changed, 676 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
>  create mode 100644 drivers/platform/x86/intel/sdsi.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel_sdsi b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> new file mode 100644
> index 000000000000..32a017ed3dd3
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> @@ -0,0 +1,75 @@
> +What:		/sys/bus/auxiliary/devices/intel_extended_cap.sdsi.X
> +Date:		Nov 2021
> +KernelVersion:	5.17
> +Contact:	"David E. Box" <david.e.box@linux.intel.com>
> +Description:
> +		This folder contains interface files for accessing Intel
> +		Software Defined Silicon (SDSi) features on a CPU. X
> +		represent the socket instance (though not the socket id).

s/represent/represents/
s/socket id/socket ID/

As a user, how do I learn the socket instance?  Look at dmesg?  Look
at some other sysfs file?

> +		Some files communicate with SDSi hardware through a mailbox.
> +		Should the operation fail, one of the following error codes
> +		may be returned:
> +
> +		Error Code	Cause
> +	        ----------	-----
> +	        EIO		General mailbox failure. Log may indicate cause.
> +	        EBUSY		Mailbox is owned by another agent.
> +	        EPERM		SDSI capability is not enabled in hardware.
> +	        EPROTO		Failure in mailbox protocol detected by driver.
> +				See log for details.
> +	        EOVERFLOW	For provision commands, the size of the data
> +				exceeds what may be written.
> +	        ESPIPE		Seeking is not allowed.
> +	        ETIMEDOUT	Failure to complete mailbox transaction in time.
> +
> +What:		/sys/bus/auxiliary/devices/intel_extended_cap.sdsi.X/guid
> +Date:		Nov 2021
> +KernelVersion:	5.17
> +Contact:	"David E. Box" <david.e.box@linux.intel.com>
> +Description:
> +		(RO) The GUID for the registers file. The GUID identifies
> +		the register layout of the registers file in this folder.
> +		Information about the register layouts for a particular GUID
> +		is available at http://github.com/intel/intel-sdsi

s/register layout of the registers file/layout of the registers file/

> +What:		/sys/bus/auxiliary/devices/intel_extended_cap.sdsi.X/registers
> +Date:		Nov 2021
> +KernelVersion:	5.17
> +Contact:	"David E. Box" <david.e.box@linux.intel.com>
> +Description:
> +		(RO) Contains information needed by applications to provision
> +		a CPU and monitor status information. The layout of this file
> +		is determined by the GUID in this folder. Information about the
> +		layout for a particular GUID is available at
> +		http://github.com/intel/intel-sdsi
> +
> +What:		/sys/bus/auxiliary/devices/intel_extended_cap.sdsi.X/provision_akc
> +Date:		Nov 2021
> +KernelVersion:	5.17
> +Contact:	"David E. Box" <david.e.box@linux.intel.com>
> +Description:
> +		(WO) Used to write an Authentication Key Certificate (AKC) to
> +		the SDSi NVRAM for the CPU. The AKC is used to authentication a
> +		Capability Activation Payload. Mailbox command.

s/used to authentication/used to authenticate/

> +What:		/sys/bus/auxiliary/devices/intel_extended_cap.sdsi.X/provision_cap
> +Date:		Nov 2021
> +KernelVersion:	5.17
> +Contact:	"David E. Box" <david.e.box@linux.intel.com>
> +Description:
> +		(WO) Used to write a Capability Activation Payload (CAP) to the
> +		SDSi NVRAM for the CPU. CAP files are used to activate a given
> +		CPU feature. The CAP file is validated by SDSi hardware using a
> +		previously provision AKC file. Upon successful authentication, the
> +		CPU configuration is updated. A cold reboot is required to fully
> +		activate the feature. Mailbox command.

"CAP file" sounds like it might be redundant.  It *seems* like the
*payload* is what will be validated by SDSi and activate the feature.
Not sure "file" is meaningful if this is really talking about the
content of the CAP.

s/previously provision/previously provisioned/

> +What:		/sys/bus/auxiliary/devices/intel_extended_cap.sdsi.X/read_state_cert
> +Date:		Nov 2021
> +KernelVersion:	5.17
> +Contact:	"David E. Box" <david.e.box@linux.intel.com>
> +Description:
> +		(RO) Used to read back the current State Certificate for the CPU
> +		from SDSi hardware. The State Certificate contains information
> +		about the current licenses on the CPU. Mailbox command.
