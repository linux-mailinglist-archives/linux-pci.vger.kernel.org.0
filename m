Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C93708D8
	for <lists+linux-pci@lfdr.de>; Sat,  1 May 2021 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhEATyG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 1 May 2021 15:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhEATyG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 May 2021 15:54:06 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E34C06174A
        for <linux-pci@vger.kernel.org>; Sat,  1 May 2021 12:53:14 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p6-20020a05600c3586b029014131bbe5c7so3473247wmq.3
        for <linux-pci@vger.kernel.org>; Sat, 01 May 2021 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C7dBD4oct0Dk9pEr7PM70Vrp3waHV0G6nXeHs3MJYK0=;
        b=jBer/R1SLBpuPWk4VLJ0OwAh98t8CQklmAphssDvTz5H6L4+0gYXSv6lO+KL8RqkUG
         MyxwtbhOct0JoWmkG7n6EghhSEQRHNr3Ehy6xKOv/FWBQSdQgy48J5q8/AqUh5ZqQLYA
         ik5yR7vqGm+AELTo/DCbBSC3t6Xo1Ypth8KfpSQsKDsY2gi1kYgVuqyVH9mhEHx9ijzW
         Xr4TTs3LgtWWVX4UKCcam5dFx9ZMjreFihvKh80U7+2c0U6I1e7FEbvLh+k5z2rwo3em
         0gSKIg2nqcXOaIjvQdGahxg+hkWUsCYPu0wqNA60bbaM/Dvg/7KAso8TRvDpeialxCcE
         8FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C7dBD4oct0Dk9pEr7PM70Vrp3waHV0G6nXeHs3MJYK0=;
        b=txlRzWjEcRGaZM/71NEEmPgmSrA481zuocCQT95JJ3fK8hO+UlQzL5P14hjzQag2N3
         xiVTwef+IUk/bJIWFw+aH5827vEJ95y0xuNfqF/zyfPpKiHMnSB/bgDAcnhdalbD426Q
         b0Oica8nRnJ23ES63gUImwE7NU6hXazqrLC3TdDn6LmBWd+YsAPO/iwEMAAPQoiGy2y0
         jmN8SXtuEwszi3xsD/b2b6S1gCiLGq6dPqV7SO7ZAMo92gJFBnLFIZ/7IpSjlmuv/G/U
         0s6O/SgsUNMTKBWXis33EN8YC7PDGC/D3mHm0iYsJgnuhczrUBN8VlqLqODhhqBAv+df
         QqBw==
X-Gm-Message-State: AOAM530f7/90CNxcevkj3wNGKEMutm80QkopcwA5UttkTIIIvRhR6Q4F
        2xTE41JfWO3fkhalBNtAnHwkMhv1U4E2/A==
X-Google-Smtp-Source: ABdhPJyt5hYcwhvfcsH4AeA1eE3ZwY0YDdqbOzfOvAKO3scPQI0kT415t7r7WFG5uKsVerKQF0HrIA==
X-Received: by 2002:a05:600c:4f14:: with SMTP id l20mr13091379wmq.150.1619898792467;
        Sat, 01 May 2021 12:53:12 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:85cf:5643:a9e6:8be4? (p200300ea8f38460085cf5643a9e68be4.dip0.t-ipconnect.de. [2003:ea:8f38:4600:85cf:5643:a9e6:8be4])
        by smtp.googlemail.com with ESMTPSA id q16sm6437350wmj.24.2021.05.01.12.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 May 2021 12:53:11 -0700 (PDT)
Subject: Re: [PATCH] PCI/VPD: Use unaligned access helpers in pci_vpd_read
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <6edebb53-b714-3205-6266-d02416fd3cfe@gmail.com>
 <202105020008.4NAsuaZ4-lkp@intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <2dc873e5-a9b5-459c-1176-16640fb146c3@gmail.com>
Date:   Sat, 1 May 2021 21:53:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <202105020008.4NAsuaZ4-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01.05.2021 18:52, kernel test robot wrote:
> Hi Heiner,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on pci/next]
> [also build test ERROR on v5.12 next-20210430]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Heiner-Kallweit/PCI-VPD-Use-unaligned-access-helpers-in-pci_vpd_read/20210501-214553
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: i386-randconfig-s002-20210501 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         # https://github.com/0day-ci/linux/commit/3115b0380e42b10762f7eee96f10b5a02cb4d2d5
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Heiner-Kallweit/PCI-VPD-Use-unaligned-access-helpers-in-pci_vpd_read/20210501-214553
>         git checkout 3115b0380e42b10762f7eee96f10b5a02cb4d2d5
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/vpd.c: In function 'pci_vpd_read':
>>> drivers/pci/vpd.c:224:4: error: implicit declaration of function 'put_unaligned_le32' [-Werror=implicit-function-declaration]
>      224 |    put_unaligned_le32(val, buf);
>          |    ^~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> 
> vim +/put_unaligned_le32 +224 drivers/pci/vpd.c
> 
>    168	
>    169	static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>    170				    void *buf)
>    171	{
>    172		struct pci_vpd *vpd = dev->vpd;
>    173		int ret;
>    174		loff_t end = pos + count;
>    175	
>    176		if (pos < 0)
>    177			return -EINVAL;
>    178	
>    179		if (!vpd->valid) {
>    180			vpd->valid = 1;
>    181			vpd->len = pci_vpd_size(dev, vpd->len);
>    182		}
>    183	
>    184		if (vpd->len == 0)
>    185			return -EIO;
>    186	
>    187		if (pos > vpd->len)
>    188			return 0;
>    189	
>    190		if (end > vpd->len) {
>    191			end = vpd->len;
>    192			count = end - pos;
>    193		}
>    194	
>    195		if (mutex_lock_killable(&vpd->lock))
>    196			return -EINTR;
>    197	
>    198		ret = pci_vpd_wait(dev);
>    199		if (ret < 0)
>    200			goto out;
>    201	
>    202		while (pos < end) {
>    203			unsigned int len, skip;
>    204			u32 val;
>    205	
>    206			ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
>    207							 pos & ~3);
>    208			if (ret < 0)
>    209				break;
>    210			vpd->busy = 1;
>    211			vpd->flag = PCI_VPD_ADDR_F;
>    212			ret = pci_vpd_wait(dev);
>    213			if (ret < 0)
>    214				break;
>    215	
>    216			ret = pci_user_read_config_dword(dev, vpd->cap + PCI_VPD_DATA, &val);
>    217			if (ret < 0)
>    218				break;
>    219	
>    220			skip = pos & 3;
>    221			len = min_t(unsigned int, 4 - skip, end - pos);
>    222	
>    223			if (len == 4)  {
>  > 224				put_unaligned_le32(val, buf);
>    225			} else {
>    226				u8 tmpbuf[4];
>    227	
>    228				put_unaligned_le32(val, tmpbuf);
>    229				memcpy(buf, tmpbuf + skip, len);
>    230			}
>    231	
>    232			buf += len;
>    233			pos += len;
>    234		}
>    235	out:
>    236		mutex_unlock(&vpd->lock);
>    237		return ret ? ret : count;
>    238	}
>    239	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

It depends on "PCI/VPD: Use unaligned access helper in pci_vpd_write"
which takes care of including asm/unaligned.h
