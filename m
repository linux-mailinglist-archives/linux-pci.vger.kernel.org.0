Return-Path: <linux-pci+bounces-21154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03C4A30894
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 11:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2B0166858
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505381F4299;
	Tue, 11 Feb 2025 10:34:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E126BD90;
	Tue, 11 Feb 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739270057; cv=none; b=YiVqK6KK+lO5c6M5ZQ9LQrEg8eWiKLbXFJPpuGczNrmG1zsmtuxhEnS9CeN1ecQFvZ+TGAozejNPimMsZnjeKIBQgRbBy/IWEWNdMGTuyA24bN/Q98z9Gk8Ji+i32N7JeaOegiX5HJUrWnM3g08swQJRHi4zUPma6qC2SYepuTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739270057; c=relaxed/simple;
	bh=/3jS/aifha0R+pmTp79dZcWCEn3BMWmxixJ6k8dX6P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cpw0fGP4wHFxKoiaozz8jPnXKSc4HVYunAueegFKdY8/qh2DQlrepzvPqIC+0g6oQR/YWH5PGsA9ZzB6GsweoivSMRSS1mPa0O1n+cnjcxoSn/LwsU6CRUAhZq7lKI5ikFM3P/X6lWfAzrRTdaB3RPlOpQa47tIhoYpFpuqD4wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 86EE561EA1BE9;
	Tue, 11 Feb 2025 11:33:51 +0100 (CET)
Message-ID: <6115a459-60b9-4880-b392-1b57f435a1a9@molgen.mpg.de>
Date: Tue, 11 Feb 2025 11:33:51 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Support BT remote wake.
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, Kiran K <kiran.k@intel.com>
References: <20250211112619.1901277-1-chandrashekar.devegowda@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250211112619.1901277-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Chandrashekar,


Thank you for your patch. Several comments on formal things.


Am 11.02.25 um 12:26 schrieb Chandrashekar Devegowda:

Your system time is set incorrectly and set to the future.

> Changes to add hdev->wakeup call to support wake on BT feature.

Please elaborate. What is the problem? How is it solved? How is it tested?

> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
> changes in v1:
>      - support for BT remote wake.

Not necessary to note v1 changes.

>   drivers/bluetooth/btintel_pcie.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index b8b241a92bf9..e0633fab55a0 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -1509,6 +1509,13 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
>   	return err;
>   }
>   
> +static bool btintel_pcie_wakeup(struct hci_dev *hdev)
> +{
> +	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
> +
> +	return device_may_wakeup(&data->pdev->dev);
> +}
> +
>   static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
>   {
>   	int err;
> @@ -1533,6 +1540,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
>   	hdev->hw_error = btintel_hw_error;
>   	hdev->set_diag = btintel_set_diag;
>   	hdev->set_bdaddr = btintel_set_bdaddr;
> +	hdev->wakeup = btintel_pcie_wakeup;
>   
>   	err = hci_register_dev(hdev);
>   	if (err < 0) {

The diff looks good.


Kind regards,

Paul

