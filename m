Return-Path: <linux-pci+bounces-33394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2127CB1AAAD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 00:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9997518A0106
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6C23C4F3;
	Mon,  4 Aug 2025 22:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsOK/WSN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353023C397;
	Mon,  4 Aug 2025 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754344808; cv=none; b=j/xqUqtrabtjznL5BHo+2Y81aIf1mlbB7WxOuBJiIBCSyKD3v8AxvknDBgU0tlVgqycvwC199YJUsM/YvogE4uZO4Ol7wqcnARAFz4gHDS1RzmapAlZhGouj8hPIm4QjxNvBjC8NHoYcNW6Sa3wZuiiAUl+msFHsKTuzqVej7pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754344808; c=relaxed/simple;
	bh=eS5SnAL6PrTwjkPDuTyKP3H4y8CytrwRk1Z/fzOFWTE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k98f/aNiwe03H3DMmqQdHejcLIejeGSqOw101EpjA1fnhoMMY/0vCRMjm8QOE1XUW2WhZI8q0sHpPXGpwC5aWIpmVqgHVgMhS1tqiBykgeURHW3x3i+TJSXM0oldCSWtMlJq91HyrK0t5BnlMqI48AidokHngafhz+5LC/MjChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsOK/WSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263F8C4CEF0;
	Mon,  4 Aug 2025 22:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754344807;
	bh=eS5SnAL6PrTwjkPDuTyKP3H4y8CytrwRk1Z/fzOFWTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XsOK/WSNf2Ic5WVPtAhVO12lhIpB1xYv+zShtB5exXKINsxksv4gP023t1feS+hqe
	 H0ikCUsacJbHmYK2limsk3UmhGTV1I91Zpe1pqHsEcVSXCZaHkDhflzMnNP0ZwI4KK
	 IuTzIPjuubuSqaG3naHx5VKI2AsfT2vnjCEhvGI411PSpSwWl/ZHz6FnyXG8dAaMAw
	 nh3xk6GrIbZQfKVxMDJoC2Q0k9KpUCkWAY3MqwLIGQ8rE2ap1u+zD7ur93O3miXHdt
	 TTHNwPM9J9IVR8lETvezeibcssWF2Lm0p3NfLpk5ssknfb0/X0RLbLTpk0ihlBY6VN
	 LHRVEmeaKyohA==
Date: Mon, 4 Aug 2025 17:00:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 05/38] tsm: Don't overload connect
Message-ID: <20250804220005.GA3644473@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-6-aneesh.kumar@kernel.org>

Only touches drivers/pci, so needs a "PCI" prefix of some flavor.

On Mon, Jul 28, 2025 at 07:21:42PM +0530, Aneesh Kumar K.V (Arm) wrote:
> We need separate handling in the guest while destroying the device.
> Hence switch to new callback lock and unlock. Hide the connect sysfs
> file in guest.
> 
> guest sysfs will now looks like

s/guest/Guest/
s/will now looks/will now look/

> ls -al  /sys/bus/pci/devices/0000:02:00.0/tsm/
> total 0
> drwxr-xr-x    2 root     root             0 Jan  1 00:00 .
> drwxr-xr-x    7 root     root             0 Jan  1 00:00 ..
> -rw-r--r--    1 root     root          4096 Jan  1 00:00 accept
> -rw-r--r--    1 root     root          4096 Jan  1 00:00 lock

Indent quoted material a couple spaces.

I don't know about TSM, so this commit log doesn't quite tell me why
we need this.

It appears this also adds a sysfs file that could be documented
somehow.

> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/pci/tsm.c       | 136 ++++++++++++++++++++++++++++++++++------
>  include/linux/pci-tsm.h |   3 +
>  2 files changed, 121 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 60f50d57a725..80607082b7f0 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -125,18 +125,6 @@ static int pci_tsm_disconnect(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> -/*
> - * TDISP locked state temporarily makes the device inaccessible, do not
> - * surprise live attached drivers
> - */
> -static int __driver_idle_connect(struct pci_dev *pdev)
> -{
> -	guard(device)(&pdev->dev);
> -	if (pdev->dev.driver)
> -		return -EBUSY;
> -	return tsm_ops->connect(pdev);
> -}
> -
>  /*
>   * When the registered ops support accept it indicates that this is a
>   * TVM-side (guest) TSM operations structure. In this mode ->connect()
> @@ -162,10 +150,7 @@ static int pci_tsm_connect(struct pci_dev *pdev)
>  	if (tsm->state >= PCI_TSM_CONNECT)
>  		return 0;
>  
> -	if (tvm_mode())
> -		rc = __driver_idle_connect(pdev);
> -	else
> -		rc = tsm_ops->connect(pdev);
> +	rc = tsm_ops->connect(pdev);
>  	if (rc)
>  		return rc;
>  	tsm->state = PCI_TSM_CONNECT;
> @@ -299,6 +284,99 @@ static ssize_t accept_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(accept);
>  
> +static int pci_tsm_unlock(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> +

Drop this blank line ...

> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);

add one here.  I'm seeing a new pattern; maybe the trend is to put
declarations of __free() things outside the usual local variable list?

> +	if (!lock)
> +		return -EINTR;
> +
> +	if (tsm->state < PCI_TSM_INIT)
> +		return -ENXIO;
> +	if (tsm->state < PCI_TSM_LOCK)
> +		return 0;
> +
> +	tsm_ops->unlock(pdev);
> +	tsm->state = PCI_TSM_INIT;
> +	pdev->dev.tdi_enabled = false;
> +
> +	return 0;
> +}
> +
> +/*
> + * TDISP locked state temporarily makes the device inaccessible, do not
> + * surprise live attached drivers
> + */
> +static int __driver_idle_lock(struct pci_dev *pdev)
> +{
> +	guard(device)(&pdev->dev);
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +	return tsm_ops->lock(pdev);
> +}
> +
> +static int pci_tsm_lock(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> +	int rc;
> +
> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (tsm->state < PCI_TSM_INIT)
> +		return -ENXIO;
> +
> +	rc = __driver_idle_lock(pdev);
> +	if (rc)
> +		return rc;
> +	tsm->state = PCI_TSM_CONNECT;
> +	return 0;
> +}
> +
> +static ssize_t lock_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	int rc;
> +	bool connect;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	rc = kstrtobool(buf, &connect);
> +	if (rc)
> +		return rc;
> +
> +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (connect)
> +		rc = pci_tsm_lock(pdev);
> +	else
> +		rc = pci_tsm_unlock(pdev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +
> +static ssize_t lock_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_tsm_pf0 *tsm;
> +
> +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (!pdev->tsm)
> +		return -ENXIO;
> +
> +	tsm = to_pci_tsm_pf0(pdev->tsm);
> +	return sysfs_emit(buf, "%d\n", tsm->state >= PCI_TSM_LOCK);
> +}
> +static DEVICE_ATTR_RW(lock);
> +
>  static umode_t pci_tsm_pf0_attr_visible(struct kobject *kobj,
>  					struct attribute *a, int n)
>  {
> @@ -306,6 +384,11 @@ static umode_t pci_tsm_pf0_attr_visible(struct kobject *kobj,
>  		/* Host context, filter out guest only attributes */
>  		if (a == &dev_attr_accept.attr)
>  			return 0;
> +		if (a == &dev_attr_lock.attr)
> +			return 0;
> +	} else {
> +		if (a == &dev_attr_connect.attr)
> +			return 0;
>  	}
>  
>  	return a->mode;
> @@ -325,6 +408,7 @@ DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);
>  static struct attribute *pci_tsm_pf0_attrs[] = {
>  	&dev_attr_connect.attr,
>  	&dev_attr_accept.attr,
> +	&dev_attr_lock.attr,
>  	NULL
>  };
>  
> @@ -537,7 +621,8 @@ static void pci_tsm_pf0_init(struct pci_dev *pdev)
>  		return;
>  
>  	pdev->tsm = no_free_ptr(pci_tsm);
> -	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	if (!tvm_mode())
> +		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
>  	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
>  	if (pci_tsm_owner_attr_group)
>  		sysfs_merge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
> @@ -602,6 +687,19 @@ static void pci_tsm_pf0_destroy(struct pci_dev *pdev)
>  	__pci_tsm_pf0_destroy(tsm);
>  }
>  
> +static void pci_tsm_guest_destroy(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
> +
> +	if (tsm->state > PCI_TSM_INIT)
> +		pci_tsm_unlock(pdev);
> +	pdev->tsm = NULL;
> +	if (pci_tsm_owner_attr_group)
> +		sysfs_unmerge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
> +	__pci_tsm_pf0_destroy(tsm);
> +}
> +
>  static void __pci_tsm_destroy(struct pci_dev *pdev)
>  {
>  	struct pci_tsm *pci_tsm = pdev->tsm;
> @@ -611,7 +709,9 @@ static void __pci_tsm_destroy(struct pci_dev *pdev)
>  
>  	lockdep_assert_held_write(&pci_tsm_rwsem);
>  
> -	if (is_pci_tsm_pf0(pdev)) {
> +	if (tvm_mode()) {
> +		pci_tsm_guest_destroy(pdev);
> +	} else if (is_pci_tsm_pf0(pdev)) {
>  		pci_tsm_pf0_destroy(pdev);
>  	} else {
>  		__pci_tsm_unbind(pdev);
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 0d4303726b25..7639e7963681 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -11,6 +11,7 @@ enum pci_tsm_state {
>  	PCI_TSM_ERR = -1,
>  	PCI_TSM_INIT,
>  	PCI_TSM_CONNECT,
> +	PCI_TSM_LOCK,
>  	PCI_TSM_ACCEPT,
>  };
>  
> @@ -153,6 +154,8 @@ struct pci_tsm_ops {
>  	void (*remove)(struct pci_tsm *tsm);
>  	int (*connect)(struct pci_dev *pdev);
>  	void (*disconnect)(struct pci_dev *pdev);
> +	int (*lock)(struct pci_dev *pdev);
> +	void (*unlock)(struct pci_dev *pdev);
>  	struct pci_tdi *(*bind)(struct pci_dev *pdev, struct pci_dev *pf0_dev,
>  				struct kvm *kvm, u64 tdi_id);
>  	void (*unbind)(struct pci_tdi *tdi);
> -- 
> 2.43.0
> 

