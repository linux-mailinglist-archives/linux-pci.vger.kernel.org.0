Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8E2376B8F
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 23:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhEGVTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 17:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhEGVTM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 May 2021 17:19:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B09C061574
        for <linux-pci@vger.kernel.org>; Fri,  7 May 2021 14:18:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a4so10577129wrr.2
        for <linux-pci@vger.kernel.org>; Fri, 07 May 2021 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vq/0n94D5tH9VVX7Dz0fjzzVUGpHPFUZGnbTux9cXsw=;
        b=SPYYBFfDEVf8vw6dAPOalt9Z0qGEWQ6NCaXxCjKiI3GwD+qcS7MQe0yTlxKx/TQKaq
         fAyRfJDemhVWxNFZ8wGqIQdQ8N45DUQG2OVx6xJpFCZ7ZjRwgZuxhAdgCqNblDZqmhEC
         a5hKqvcMKhc07WdjXgX28Wj2jfVSe5zHOJO6zDJrnRz88CIpaUTOelN42qOmEx0+tqZL
         b8sHMvoBt6koKUsezf2BofPh2/PXNuv0uKAN12GlJRSu2hLxDzU8d329woTBZn/YqcEp
         LJkCK7etT8KrKpGG9xvATtkJHjn/xhOTiI3iQkX93YPT+ATwo7rLyHBe0Qhx6SzrNaHf
         98jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vq/0n94D5tH9VVX7Dz0fjzzVUGpHPFUZGnbTux9cXsw=;
        b=YVimmD2uVdrCd1PtFKF+Gi7OnrFDgkKlv1x5p57w76XNN06M31QcAaIFFAP7+UL6y+
         Oh2K1VPeml7wkk3E2Ml/ofel0a89ShemJv+Yi7385DFHeQqrAWRq2NH8hUk8Ev3M6433
         9d6M1l/FESfj3aBE/ICrSjrUE8ApVcBGdXn5Z2C3pKpjfCUT+GwTdLwVktSYg9Deod6P
         878pS5zokaok+YDDW9QpMSnBubaMSigeZi7aGK5F4QsP9nSV+9E7zf7YWxGFsB0NcFZO
         Vkn/QUeMboSA3vtC3uXo49RhiDn6zKsUISf5Ac8EOLQkRz7lD6l4DnAmfhu8bBfVkwwV
         FkEA==
X-Gm-Message-State: AOAM530L8K4MPNeiqKprzfBe1QFOHd/sY3js24/t5hDkoiKaujAuWVro
        dxa5Vmmpl6V6IRNEdzKEiQZOhsp4G5F7og==
X-Google-Smtp-Source: ABdhPJwJ/fKJA3p5aBwIW0cy5gY6M3rs1eBvAFHTrquWKTkuxapdVMabwswu6pI5qbMk7PZ9qjcJgA==
X-Received: by 2002:adf:efc6:: with SMTP id i6mr15115801wrp.408.1620422290373;
        Fri, 07 May 2021 14:18:10 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:b4c6:4571:e0db:c0d3? (p200300ea8f384600b4c64571e0dbc0d3.dip0.t-ipconnect.de. [2003:ea:8f38:4600:b4c6:4571:e0db:c0d3])
        by smtp.googlemail.com with ESMTPSA id r13sm9805554wrn.2.2021.05.07.14.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 14:18:08 -0700 (PDT)
Subject: Re: [PATCH] PCI/VPD: Use unaligned access helpers in pci_vpd_read
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <6edebb53-b714-3205-6266-d02416fd3cfe@gmail.com>
 <202105020008.4NAsuaZ4-lkp@intel.com>
 <2dc873e5-a9b5-459c-1176-16640fb146c3@gmail.com>
Message-ID: <94c5a3f5-0714-7b50-6f8a-73a6a74f9225@gmail.com>
Date:   Fri, 7 May 2021 23:18:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2dc873e5-a9b5-459c-1176-16640fb146c3@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01.05.2021 21:53, Heiner Kallweit wrote:
> On 01.05.2021 18:52, kernel test robot wrote:
>> Hi Heiner,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on pci/next]
>> [also build test ERROR on v5.12 next-20210430]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Heiner-Kallweit/PCI-VPD-Use-unaligned-access-helpers-in-pci_vpd_read/20210501-214553
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
>> config: i386-randconfig-s002-20210501 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>> reproduce:
>>         # apt-get install sparse
>>         # sparse version: v0.6.3-341-g8af24329-dirty
>>         # https://github.com/0day-ci/linux/commit/3115b0380e42b10762f7eee96f10b5a02cb4d2d5
>>         git remote add linux-review https://github.com/0day-ci/linux
>>         git fetch --no-tags linux-review Heiner-Kallweit/PCI-VPD-Use-unaligned-access-helpers-in-pci_vpd_read/20210501-214553
>>         git checkout 3115b0380e42b10762f7eee96f10b5a02cb4d2d5
>>         # save the attached .config to linux build tree
>>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=i386 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/pci/vpd.c: In function 'pci_vpd_read':
>>>> drivers/pci/vpd.c:224:4: error: implicit declaration of function 'put_unaligned_le32' [-Werror=implicit-function-declaration]
>>      224 |    put_unaligned_le32(val, buf);
>>          |    ^~~~~~~~~~~~~~~~~~
>>    cc1: some warnings being treated as errors
>>
>>
>> vim +/put_unaligned_le32 +224 drivers/pci/vpd.c
>>
>>    168	
>>    169	static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>>    170				    void *buf)
>>    171	{
>>    172		struct pci_vpd *vpd = dev->vpd;
>>    173		int ret;
>>    174		loff_t end = pos + count;
>>    175	
>>    176		if (pos < 0)
>>    177			return -EINVAL;
>>    178	
>>    179		if (!vpd->valid) {
>>    180			vpd->valid = 1;
>>    181			vpd->len = pci_vpd_size(dev, vpd->len);
>>    182		}
>>    183	
>>    184		if (vpd->len == 0)
>>    185			return -EIO;
>>    186	
>>    187		if (pos > vpd->len)
>>    188			return 0;
>>    189	
>>    190		if (end > vpd->len) {
>>    191			end = vpd->len;
>>    192			count = end - pos;
>>    193		}
>>    194	
>>    195		if (mutex_lock_killable(&vpd->lock))
>>    196			return -EINTR;
>>    197	
>>    198		ret = pci_vpd_wait(dev);
>>    199		if (ret < 0)
>>    200			goto out;
>>    201	
>>    202		while (pos < end) {
>>    203			unsigned int len, skip;
>>    204			u32 val;
>>    205	
>>    206			ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
>>    207							 pos & ~3);
>>    208			if (ret < 0)
>>    209				break;
>>    210			vpd->busy = 1;
>>    211			vpd->flag = PCI_VPD_ADDR_F;
>>    212			ret = pci_vpd_wait(dev);
>>    213			if (ret < 0)
>>    214				break;
>>    215	
>>    216			ret = pci_user_read_config_dword(dev, vpd->cap + PCI_VPD_DATA, &val);
>>    217			if (ret < 0)
>>    218				break;
>>    219	
>>    220			skip = pos & 3;
>>    221			len = min_t(unsigned int, 4 - skip, end - pos);
>>    222	
>>    223			if (len == 4)  {
>>  > 224				put_unaligned_le32(val, buf);
>>    225			} else {
>>    226				u8 tmpbuf[4];
>>    227	
>>    228				put_unaligned_le32(val, tmpbuf);
>>    229				memcpy(buf, tmpbuf + skip, len);
>>    230			}
>>    231	
>>    232			buf += len;
>>    233			pos += len;
>>    234		}
>>    235	out:
>>    236		mutex_unlock(&vpd->lock);
>>    237		return ret ? ret : count;
>>    238	}
>>    239	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> 
> It depends on "PCI/VPD: Use unaligned access helper in pci_vpd_write"
> which takes care of including asm/unaligned.h
> 
Please disregard this patch, I'll send a slightly improved v2.
