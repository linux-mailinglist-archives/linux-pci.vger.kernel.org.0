Return-Path: <linux-pci+bounces-4166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A31F86A461
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 01:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07036288247
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 00:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47A136F;
	Wed, 28 Feb 2024 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO8GM/Py"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCE5363;
	Wed, 28 Feb 2024 00:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079932; cv=none; b=sOSAhzTuN32yKuIQ3oVYiL9ITpJ8HaBI2SKqnoFRpQN+J6XQpZQoOQNPxhKuJp296IDTcQ1JNoITaJOFOPdBceC3pqG+Gbo5v762hlXyggGFsT27O319eo+lIkMFdEs5kPyk2DgKVN8cDJClellM8JqjPPGFful4rSTSgPUXTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079932; c=relaxed/simple;
	bh=RfHADThP6ohdZVQWYVOk7Sb8DwO11tqy+hiODNSiMEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=u5Ltyi1ohCQ9E0ZwhWiJ8m8oVH6PUAMLoA08eka7OpeLKidDvmZ2OEqVmnz68iAC2ilYXvNR/tG5JD+X3JHipzfzdYwEgShKCKVsiRVtGEa8lWhJ9h9P1jL+uNSpon3aEF5bZuXeMhg3ApHq85GKu4l4WzIZBq4d8AomlCGzxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO8GM/Py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076F5C433F1;
	Wed, 28 Feb 2024 00:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709079932;
	bh=RfHADThP6ohdZVQWYVOk7Sb8DwO11tqy+hiODNSiMEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lO8GM/PyiLXhVmhZ17H2eIOKR2dm9RTQw9wUpBcOzUzlkmp0mzqFcZXTM/cZ0KR75
	 h7Ehn0DUKKxrQ14U+HQdrhZgR/BpP9Ur053WHhPqy11WCHlVRKY2JbI4EONxKGaXrg
	 HOt4Aq3bcyarvUP0qQy2NkN9B7XGvnk6Xq4XDlJ3GwNmZHTTBI7+e1zk8uL/KhtK6C
	 jrc5X6a5ai6gxWu1fzlA7U/zNGOikAMied4VFHotbukbnNr1oMxBO0kOpbYF0iac6y
	 NOWxCGno1KjE1NHguS8/9Lt9+npN0wLsdJvRYwxn3xThRCtTN34SkHS1ZWq8IX1OYv
	 KNRVkbNpgp2MQ==
Date: Tue, 27 Feb 2024 18:25:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, vireshk@kernel.org,
	quic_vbadigan@quicinc.com, quic_skananth@quicinc.com,
	quic_nitegupt@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH v7 6/7] PCI: Bring out the pcie link speed to MBps logic
 to new function
Message-ID: <20240228002530.GA250175@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-opp_support-v7-6-10b4363d7e71@quicinc.com>

Mention the new interface name in the subject and in the commit log.

s/pcie/PCIe/

The subject says "to MBps", but the commit log says "to frequency".

On Fri, Feb 23, 2024 at 08:18:03PM +0530, Krishna chaitanya chundru wrote:
> Bring the switch case in pcie_link_speed_mbps to new function to
> the header file so that it can be used in other places like
> in controller driver.

s/pcie_link_speed_mbps/pcie_link_speed_mbps()/ to identify it as a
function.

> Create a new macro to convert from MBps to frequency.

Include the new macro name here.

I think pcie_link_speed_mbps() returns Mb/s (mega*bits* per second),
not MB/s (mega*bytes* per second).

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/pci.c | 19 +------------------
>  drivers/pci/pci.h | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d8f11a078924..b441ab862a8d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6309,24 +6309,7 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
>  	if (err)
>  		return err;
>  
> -	switch (to_pcie_link_speed(lnksta)) {
> -	case PCIE_SPEED_2_5GT:
> -		return 2500;
> -	case PCIE_SPEED_5_0GT:
> -		return 5000;
> -	case PCIE_SPEED_8_0GT:
> -		return 8000;
> -	case PCIE_SPEED_16_0GT:
> -		return 16000;
> -	case PCIE_SPEED_32_0GT:
> -		return 32000;
> -	case PCIE_SPEED_64_0GT:
> -		return 64000;
> -	default:
> -		break;
> -	}
> -
> -	return -EINVAL;
> +	return pcie_link_speed_to_mbps(to_pcie_link_speed(lnksta));
>  }
>  EXPORT_SYMBOL(pcie_link_speed_mbps);
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2336a8d1edab..82e715ebe383 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -282,6 +282,30 @@ void pci_bus_put(struct pci_bus *bus);
>  	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
>  	 0)
>  
> +static inline int pcie_link_speed_to_mbps(enum pci_bus_speed speed)
> +{
> +	switch (speed) {
> +	case PCIE_SPEED_2_5GT:
> +		return 2500;
> +	case PCIE_SPEED_5_0GT:
> +		return 5000;
> +	case PCIE_SPEED_8_0GT:
> +		return 8000;
> +	case PCIE_SPEED_16_0GT:
> +		return 16000;
> +	case PCIE_SPEED_32_0GT:
> +		return 32000;
> +	case PCIE_SPEED_64_0GT:
> +		return 64000;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +#define PCIE_MBS2FREQ(speed) (pcie_link_speed_to_mbps(speed) * 1000)

I feel like I might have asked some of this before; if so, my
apologies and maybe a comment would be useful here to save answering
again.

The MBS2FREQ name suggests that "speed" is Mb/s, but it's not; it's an
enum pci_bus_speed just like PCIE_SPEED2MBS_ENC() takes.

When PCI SIG defines a new data rate, PCIE_MBS2FREQ() will do
something completely wrong when pcie_link_speed_to_mbps() returns
-EINVAL.  I think it would be better to do this in a way that we can
warn about the unknown speed and fall back to some reasonable default
instead of whatever (-EINVAL * 1000) works out to.

PCIE_MBS2FREQ() looks an awful lot like PCIE_SPEED2MBS_ENC(), except
that it doesn't adjust for the encoding overhead and it multiplies by
1000.  I don't know what that result means.  The name suggests a
frequency?

  pcie_link_speed_to_mbps(PCIE_SPEED_2_5GT) == 2500 Mbit/s (raw data rate)
  PCIE_SPEED2MBS_ENC(PCIE_SPEED_2_5GT) == 2000 Mbit/s or 2 Gbit/s (effective data rate)
  PCIE_MBS2FREQ(PCIE_SPEED_2_5GT) == 2500000 (? 2.5M of something)

I don't really know how OPP works, but it looks like maybe
PCIE_MBS2FREQ() is a shim that depends on how the OPP tables in DT are
encoded?  I'm surprised that the DT OPP tables aren't encoded with
either the raw data rate or the effective data rate directly instead
of what looks like the raw data rate / 1000.

Is this a standard OPP encoding that will apply to other drivers?  If
so, it would be helpful to point to where that encoding is defined.
If not, PCIE_MBS2FREQ() should probably be defined in pcie-qcom.c.

Bjorn

