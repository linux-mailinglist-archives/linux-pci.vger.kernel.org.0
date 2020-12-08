Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA9E2D30CC
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 18:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgLHRTT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 12:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbgLHRTT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 12:19:19 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06D7C061793;
        Tue,  8 Dec 2020 09:18:38 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id k4so18408529edl.0;
        Tue, 08 Dec 2020 09:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YsRTsMesCTliRWq4glF76HNwn9ElWJpIdmHckoW2bvo=;
        b=C6rysrLLV7sfxL+MVzuGx2dgpynoaKZwkG5aZ+HfF+/4msF1fH8Xam/Rm/CJWSwFmO
         88pVRExhJ9bYiRSmD5noxb6tqNsZVnaRKHFQhBi46KliVnzSkyXxFp0Utd03rVh9HZr2
         JbE/0mvw+PnMIl2HuB+rXqehij9oUY1LSyXIBclOeFtvHy+GsW0vFK6BOXHPw/5hgRxU
         g509UkB/dWzQyXPk+zVIh07+JliwiT2A1g+fFo0Fll5CyKSn4BqVhI/wDf9eWccBEu3g
         v4O7d6AYBUXLtWUGkZurD1PXupxAwqP0lBivwg+AVU+OKHpI7jrgFWhBRc+VuDFBRrZe
         S4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=YsRTsMesCTliRWq4glF76HNwn9ElWJpIdmHckoW2bvo=;
        b=qgu5YK4SFAeoBEffn9nNcYaCRrF3A248gghwatWkRy7nibI/oPPxNkVfLAlvCzMR4z
         Xi6eDUyTUJJcdFcH2umsZnbgGFbp/lerTfwtkn6Twut5gxCHq1ByYZzctv45EVCSVkVr
         C6DT6g41HBfiTxy3vCroe6RJcxwuCy5bgEVAHnUZA9FWBB3Mn/Hu8A9C5RMEl27nPsQl
         Wc2oRcaj6a5B7UkoPA1z0kLcrpFzqo36Eq8Uk2ZLJ1FzrcLm2eEfNqbRXzd7RhiuAVrH
         xEkc4j8ycXIJ8XsztxvUTDnNsUJ4eI0Uoey0Rkk5sQNiptsJNsh8csqsVIr01XmR50mB
         HssA==
X-Gm-Message-State: AOAM531ANcsjeQcAO8B13+CerG1n13+zqp49An0sSycWsJxFV/sURAfG
        3FQX8CQMZ32LU7Ura0TtATopK/8Z+dc=
X-Google-Smtp-Source: ABdhPJxFJFhmprL9FiUn3tPn/fQwnmKhZr5/OMewcYe2zAlrGaCBV56eF5K/klQt3ixGkdieNipNXQ==
X-Received: by 2002:a05:6402:8cc:: with SMTP id d12mr25266684edz.0.1607447917370;
        Tue, 08 Dec 2020 09:18:37 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:580f:b429:3aa2:f8b1? (p200300ea8f065500580fb4293aa2f8b1.dip0.t-ipconnect.de. [2003:ea:8f06:5500:580f:b429:3aa2:f8b1])
        by smtp.googlemail.com with ESMTPSA id ef11sm3659979ejb.15.2020.12.08.09.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 09:18:36 -0800 (PST)
Subject: Re: [PATCH 2/2] PCI/ASPM: Use capability to override ASPM via sysfs
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201208082534.2460215-1-kai.heng.feng@canonical.com>
 <20201208082534.2460215-2-kai.heng.feng@canonical.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <d47544b3-b9a0-609c-fc97-527c9416f9a0@gmail.com>
Date:   Tue, 8 Dec 2020 18:18:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201208082534.2460215-2-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 08.12.2020 um 09:25 schrieb Kai-Heng Feng:
> If we are to use sysfs to change ASPM settings, we may want to override
> the default ASPM policy.
> 
> So use ASPM capability, instead of default policy, to be able to use all
> possible ASPM states.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aspm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 2ea9fddadfad..326da7bbc84d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1239,8 +1239,7 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>  
>  		link->aspm_disable |= state;
>  	}
> -
> -	pcie_config_aspm_link(link, policy_to_aspm_state(link));
> +	pcie_config_aspm_link(link, link->aspm_capable);
>  
I like the idea, because the policy can be changed by the user anyway.
Therefore I don't see it as a hard system limit.

However I think this change is not sufficient. Each call to
pcie_config_aspm_link(link, policy_to_aspm_state(link)), e.g. in path
pcie_aspm_pm_state_change -> pcie_config_aspm_path will reset the
enabled states to the policy.

>  	mutex_unlock(&aspm_lock);
>  	up_read(&pci_bus_sem);
> 

