Return-Path: <linux-pci+bounces-27276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F453AAC2A7
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 13:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55B63BA344
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58D27C16A;
	Tue,  6 May 2025 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HO0DF0TS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E68278742;
	Tue,  6 May 2025 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530975; cv=none; b=NZKQVeo7iaP9+EWemRhpvoxwstcSRKO3YhC/b6h7vyAzPv5IG30fsTlmCxVFO7oqTY1jbgQTkhKzY7ZjZIbieYa1LOkfS/0YNoGpdo7e80HhyAmV575FXdY1p8ENCpbih/zzuaEta+45bGlQnxPD/xWqd91sIe+4BgNX1R+wBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530975; c=relaxed/simple;
	bh=J2XT4AUKONpaTXWQDPzjZYfmF/odE31sTcUZ9Rj62HU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlpF/ckKVCAQLEoyuyJqyohZQDtOjEmE3wca9aiZ4vBKYG5UIy3AelxnXb+dj6kYiIIsWgFnYe6V2dGunvQSDity5RJkXDn8Yy66aZkSxR/IQAmL7wLafdo+opMpS6OldsGLtViQfvQVaFFlphxYjmzWj5VJ84kQRLIJF3sz+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HO0DF0TS; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1746530957; x=1746790157;
	bh=J2XT4AUKONpaTXWQDPzjZYfmF/odE31sTcUZ9Rj62HU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=HO0DF0TSGjKYgVq+u1Y+M6W14ultpXfkvDmlxQFKVYiMD5v+HTSs3TCP6fnik3/p0
	 tjL82DqE2XAwu3wa7Kb/9ggXFr57EhXKyNqFVvXjtQ3lUnAKu2HmEMFs2AMp4p5BT9
	 j3wkssJExd6IGnC8S8PxcHALQHXilbGMfBx15cXk1XJi+cAjeKxyWBJztw1PSJbb/3
	 4hAQ5g1o8GZKnriSpYY1bGrFOsQALAPQwCj+cY4q9G9i3oT9HMoXdv/3md28jrnJSV
	 gNHNou5ZOMhqPMXtHiJk6JLSgjvZw+HTAo7FfObX1bCC2g0rdWYl9jyZouDb8vXAwO
	 7OTA+fFf+t72A==
Date: Tue, 06 May 2025 11:29:14 +0000
To: Niklas Cassel <cassel@kernel.org>
From: Laszlo Fiat <laszlo.fiat@proton.me>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krishna chaitanya chundru <quic_krichai@quicinc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] PCI: qcom: Do not enumerate bus before endpoint devices are ready
Message-ID: <4r2xPb3Ic9SP9d4CU7Ru6X1mMXGXJIvC1NYBDwmEqGpMpul-Hgx1tG5ERjyHncqvZ42Ys_x16ut7PGPmtPQCJKbQRyYbNAY7tEpUY-_8Dks=@proton.me>
In-Reply-To: <20250506073934.433176-8-cassel@kernel.org>
References: <20250506073934.433176-6-cassel@kernel.org> <20250506073934.433176-8-cassel@kernel.org>
Feedback-ID: 130963441:user:proton
X-Pm-Message-ID: 6916607993085f1c4cfc8ca8f11722f473805ac8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Tuesday, May 6th, 2025 at 9:39 AM, Niklas Cassel <cassel@kernel.org> wro=
te:

> Commit 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Lin=
k
> Up") changed so that we no longer call dw_pcie_wait_for_link(), and inste=
ad
> enumerate the bus when receiving a Link Up IRQ.
>=20
> Before 36971d6c5a9a, we called dw_pcie_wait_for_link(), and in the first
> iteration of the loop, the link will never be up (because the link was ju=
st
> started), dw_pcie_wait_for_link() will then sleep for LINK_WAIT_SLEEP_MS
> (90 ms), before trying again.
>=20
> This means that even if a driver was missing a msleep(PCIE_T_RRS_READY_MS=
)
> (100 ms), because of the call to dw_pcie_wait_for_link(), enumerating the
> bus would essentially be delayed by that time anyway (because of the slee=
p
> LINK_WAIT_SLEEP_MS (90 ms)).
>=20
> While we could add the msleep(PCIE_T_RRS_READY_MS) after deasserting PERS=
T
> (qcom already has an unconditional 1 ms sleep after deasserting PERST),
> that would essentially bring back an unconditional delay during probe (th=
e
> whole reason to use a Link Up IRQ was to avoid an unconditional delay
> during probe).
>=20
> Thus, add the msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in t=
he
> IRQ handler. This way, for qcom SoCs that has a link up IRQ, we will not
> have a 100 ms unconditional delay during boot for unpopulated PCIe slots.
>=20
> Fixes: 36971d6c5a9a ("PCI: qcom: Don't wait for link if we can detect Lin=
k Up")
> Signed-off-by: Niklas Cassel cassel@kernel.org
>=20
> ---
> drivers/pci/controller/dwc/pcie-qcom.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index dc98ae63362d..01a60d1f372a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1565,6 +1565,7 @@ static irqreturn_t qcom_pcie_global_irq_thread(int =
irq, void data)
>=20
> if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
> dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> + msleep(PCIE_T_RRS_READY_MS);
> / Rescan the bus to enumerate endpoint devices */
> pci_lock_rescan_remove();
> pci_rescan_bus(pp->bridge->bus);
>=20
> --
> 2.49.0

Tested-by: Laszlo Fiat <laszlo.fiat@proton.me>

