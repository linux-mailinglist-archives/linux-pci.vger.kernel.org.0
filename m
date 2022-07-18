Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C715578722
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jul 2022 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbiGRQWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiGRQWF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 12:22:05 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7267E2A414
        for <linux-pci@vger.kernel.org>; Mon, 18 Jul 2022 09:22:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a10so14231256ljj.5
        for <linux-pci@vger.kernel.org>; Mon, 18 Jul 2022 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gnhzl8AV0IevaeOqkOrbzpbXv8n6BNxG2ZRn/9lxH9g=;
        b=U+kOT7919lLIV5hgAHfLCeFLNWoe6ERaJnxxRw1TKiDC7MfJjIXmpa0xU5m/Uh0rz3
         EWwrnMUJeT/pTCHGcrSpbzEcZdiZBIeCwILTQ5xumjFEqfwH9nF5GIwUiRR8h5Ov0Qsw
         OF4YeYQ3CZ9Dls0/dLacIQAuwBWQ+akD0/daipf6WEvqGus8uOy2NF2CK1csD6+1EnNT
         rbxaBoCiR2MOufFQRuD5JB/P6JsL6vq2awMZRC1kQlsSXbxPjLPFLf8v22CNHig0TUy4
         9+JRoVprxfJVXducukBoGcjiRFwPmKS8p0mqakiAf+1mfepTzUYHMF30hUvr64IXCuxJ
         xUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gnhzl8AV0IevaeOqkOrbzpbXv8n6BNxG2ZRn/9lxH9g=;
        b=iaG5gvhOx9eyOO4NG/mWGYN2cL58rd6+dmwtYHeTVmL03KMkxddvweSwS8wH8NNhWp
         eDEefujglMmKW7SNLsD26QohpWFe59UzEbdBQBW3dE7ipfao47KBVSkOQUumEWG9ItUv
         8yQfEzh5o9k6GFZM/6G3ItOu6zifnuFKm7yASQudT2ra+mC6qeLM5asaewe3mEo3nYr7
         K0NR2oqORR47AmEDblS9WH7oA2OYN5SYwPbcKjCwYr+SoOyAqHZ9Rc5XmKCENmqeUkWw
         l4HmRHt2wZfi5pf3RJT0M8l3CtILeCtR1rIAw4psha9ZZkP3dH8R/I7Hbtv/TEn9CbGk
         waYg==
X-Gm-Message-State: AJIora+AFTdnldjbQPYuxle8+zMF45t/xeuwna1V5tTiO2HSD9QCc+dF
        XKGphsEKWeQYNKgo88fe5tIJeg==
X-Google-Smtp-Source: AGRyM1u/ldBvC8/9GQl6gU/uzMlWEFWVdqqS2949zozHWxiwR574uX1lG9v35lqzBpUtqOK3A43/kQ==
X-Received: by 2002:a2e:be8a:0:b0:25d:c49e:fa29 with SMTP id a10-20020a2ebe8a000000b0025dc49efa29mr213513ljr.194.1658161321494;
        Mon, 18 Jul 2022 09:22:01 -0700 (PDT)
Received: from [10.43.1.253] ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id u1-20020ac258c1000000b0047f943112e3sm2674134lfo.285.2022.07.18.09.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 09:21:59 -0700 (PDT)
Message-ID: <820dff42-67e4-32d2-a72f-9e9bdb70609e@semihalf.com>
Date:   Mon, 18 Jul 2022 18:21:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] PCI/ASPM: Disable ASPM when save/restore PCI state
Content-Language: en-US
To:     Victor Ding <victording@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Zide Chen <zide.chen@intel.com>
References: <20210311173433.GA2071075@bjorn-Precision-5520>
 <20210726220307.GA647936@bjorn-Precision-5520>
 <CANqTbdb_h_W+8kmh6s56deA8VKn6tO1KDJaS5Yasq5RFLtGUbQ@mail.gmail.com>
From:   Dmytro Maluka <dmy@semihalf.com>
In-Reply-To: <CANqTbdb_h_W+8kmh6s56deA8VKn6tO1KDJaS5Yasq5RFLtGUbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Victor and Bjorn,

On 2/9/22 09:03, Victor Ding wrote:
> I sincerely apologize that I missed your two emails last year. Please find my
> comments embedded below.
> 
> On Tue, Jul 27, 2021 at 8:03 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>> On Thu, Mar 11, 2021 at 11:34:33AM -0600, Bjorn Helgaas wrote:
>>> On Thu, Jan 28, 2021 at 03:52:42PM +0000, Victor Ding wrote:
>>>> Certain PCIe devices (e.g. GL9750) have high penalties (e.g. high Port
>>>> T_POWER_ON) when exiting L1 but enter L1 aggressively. As a result,
>>>> such devices enter and exit L1 frequently during pci_save_state and
>>>> pci_restore_state; eventually causing poor suspend/resume performance.
>>>>
>>>> Based on the observation that PCI accesses dominance pci_save_state/
>>>> pci_restore_state plus these accesses are fairly close to each other, the
>>>> actual time the device could stay in low power states is negligible.
>>>> Therefore, the little power-saving benefit from ASPM during suspend/resume
>>>> does not overweight the performance degradation caused by high L1 exit
>>>> penalties.
>>>>
>>>> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211187
>>>
>>> Thanks for this!
>>>
>>> This device can tolerate unlimited delay for L1 exit (DevCtl Endpoint
>>> L1 Acceptable Latency is unlimited) and it makes no guarantees about
>>> how fast it can exit L1 (LnkCap L1 Exit Latency is also unlimited), so
>>> I think there's basically no restriction on when it can enter ASPM
>>> L1.0.
>>>
>>> I have a hard time interpreting the L1.2 entry conditions in PCIe
>>> r5.0, sec 5.5.1, but I can believe it enters L1.2 aggressively since
>>> the device says it can tolerate any latencies.
>>>
>>> If L1.2 exit takes 3100us, it could do ~60 L1 exits in 200ms.  I guess
>>> config accesses and code execution can account for some of that, but
>>> still seems like a lot of L1 entries/exits during suspend.  I wouldn't
>>> think we would touch the device that much and that intermittently.
>>>
>>>> Signed-off-by: Victor Ding <victording@google.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Updated commit message to remove unnecessary information
>>>> - Fixed a bug reading wrong register in pcie_save_aspm_control
>>>> - Updated to reuse existing pcie_config_aspm_dev where possible
>>>> - Fixed goto label style
>>>>
>>>>  drivers/pci/pci.c       | 18 +++++++++++++++---
>>>>  drivers/pci/pci.h       |  6 ++++++
>>>>  drivers/pci/pcie/aspm.c | 27 +++++++++++++++++++++++++++
>>>>  include/linux/pci.h     |  1 +
>>>>  4 files changed, 49 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 32011b7b4c04..9ea88953f90b 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -1542,6 +1542,10 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
>>>>  int pci_save_state(struct pci_dev *dev)
>>>>  {
>>>>     int i;
>>>> +
>>>> +   pcie_save_aspm_control(dev);
>>>> +   pcie_disable_aspm(dev);
>>>
>>> If I understand this patch correctly, it basically does this:
>>>
>>>     pci_save_state
>>>   +   pcie_save_aspm_control
>>>   +   pcie_disable_aspm
>>>       <save state>
>>>   +   pcie_restore_aspm_control
>>>
>>> The <save state> part is just a bunch of config reads with very little
>>> other code execution.  I'm really surprised that there's enough time
>>> between config reads for the link to go to L1.  I guess you've
>>> verified that this does speed up suspend significantly, but this just
>>> doesn't make sense to me.
>>>
>>> In the bugzilla you say the GL9750 can go to L1.2 after ~4us of
>>> inactivity.  That's enough time for a lot of code execution.  We must
>>> be missing something.  There's so much PCI traffic during save/restore
>>> that it should be easy to match up the analyzer trace with the code.
>>> Can you get any insight into what's going on that way?
> 
> Unfortunately I did not and still do not have access to the required analyzers.
> However, I received an analyzer trace screenshot confirming GL9750 indeed
> went idle for ~4.2us. (I've attached it to the bugzilla).
> 
> I agree that 4us is more than sufficient for a lot of code execution, especially
> these PCI config space accesses for the same device appear to be fairly
> close to each other. However, as device resumes occur in parallel and a
> global mutex is required for each access, these PCI config space accesses
> from multiple devices are serialized arbitrarily causing accesses from the
> same device far apart from each other.
> 
> The hypothesis came from my observation that PCI config space accesses
> from different devices in the slow runs were always interleaved, while they
> were mostly grouped together in the fast runs. To further prove the hypothesis,
> I added a global lock when save/restore PCI state, forcing the related PCI
> config space accesses from the same device grouped together, I always got
> fast runs.

I also happen to be working with a platform with GL9750 and I can
confirm Victor's observations and conclusion: PCI config accesses in
pci_save_state()/pci_restore_state() are so far apart in time because
they are arbitrarily serialized with PCI config accesses for other
devices during parallel suspend/resume, since they use the global
pci_config_lock in pci_conf1_read()/pci_conf1_write().

By the way, there is an easier way to confirm this conclusion: instead
of adding a global lock around PCI state save/restore as Victor did,
we can just disable parallel suspend/resume via
"echo 0 >/sys/power/pm_async".

So it seems we understand what's going on. Can we move forward with
merging Victor's patch?

While we're at it, I'm also wondering why for the basic PCI config (the
first 256 bytes) Linux on x86 always uses the legacy 0xCF8/0xCFC method
instead of MMCFG, even if MMCFG is available. The legacy method is
inherently non-atomic and does require the global lock, while the MMCFG
method generally doesn't, so using MMCFG would significantly speed up
PCI config accesses in high-contention scenarios like the parallel
suspend/resume.

I've tried the below change which forces using MMCFG for the first 256
bytes, and indeed, it makes suspend/resume of individual PCI devices
with pm_async=1 almost as fast as with pm_async=0. In particular, it
fixes the problem with slow GL9750 suspend/resume even without Victor's
patch.

--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -40,20 +40,20 @@ const struct pci_raw_ops *__read_mostly raw_pci_ext_ops;
 int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
                                                int reg, int len, u32 *val)
 {
-       if (domain == 0 && reg < 256 && raw_pci_ops)
-               return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
        if (raw_pci_ext_ops)
                return raw_pci_ext_ops->read(domain, bus, devfn, reg, len, val);
+       if (domain == 0 && reg < 256 && raw_pci_ops)
+               return raw_pci_ops->read(domain, bus, devfn, reg, len, val);
        return -EINVAL;
 }
 
 int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
                                                int reg, int len, u32 val)
 {
-       if (domain == 0 && reg < 256 && raw_pci_ops)
-               return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
        if (raw_pci_ext_ops)
                return raw_pci_ext_ops->write(domain, bus, devfn, reg, len, val);
+       if (domain == 0 && reg < 256 && raw_pci_ops)
+               return raw_pci_ops->write(domain, bus, devfn, reg, len, val);
        return -EINVAL;
 }
 

Sounds good if I submit a patch like this? (I'm not suggesting it
instead of Victor's patch, rather as a separate improvement.)

Thanks,
Dmytro

> 
>>
>> I'm dropping this for now, pending a better understanding of what's
>> going on.
>>
>>>>     /* XXX: 100% dword access ok here? */
>>>>     for (i = 0; i < 16; i++) {
>>>>             pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
>>>> @@ -1552,18 +1556,22 @@ int pci_save_state(struct pci_dev *dev)
>>>>
>>>>     i = pci_save_pcie_state(dev);
>>>>     if (i != 0)
>>>> -           return i;
>>>> +           goto exit;
>>>>
>>>>     i = pci_save_pcix_state(dev);
>>>>     if (i != 0)
>>>> -           return i;
>>>> +           goto exit;
>>>>
>>>>     pci_save_ltr_state(dev);
>>>>     pci_save_aspm_l1ss_state(dev);
>>>>     pci_save_dpc_state(dev);
>>>>     pci_save_aer_state(dev);
>>>>     pci_save_ptm_state(dev);
>>>> -   return pci_save_vc_state(dev);
>>>> +   i = pci_save_vc_state(dev);
>>>> +
>>>> +exit:
>>>> +   pcie_restore_aspm_control(dev);
>>>> +   return i;
>>>>  }
>>>>  EXPORT_SYMBOL(pci_save_state);
>>>>
>>>> @@ -1661,6 +1669,8 @@ void pci_restore_state(struct pci_dev *dev)
>>>>     if (!dev->state_saved)
>>>>             return;
>>>>
>>>> +   pcie_disable_aspm(dev);
>>>> +
>>>>     /*
>>>>      * Restore max latencies (in the LTR capability) before enabling
>>>>      * LTR itself (in the PCIe capability).
>>>> @@ -1689,6 +1699,8 @@ void pci_restore_state(struct pci_dev *dev)
>>>>     pci_enable_acs(dev);
>>>>     pci_restore_iov_state(dev);
>>>>
>>>> +   pcie_restore_aspm_control(dev);
>>>> +
>>>>     dev->state_saved = false;
>>>>  }
>>>>  EXPORT_SYMBOL(pci_restore_state);
>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>> index a81459159f6d..e074a0cbe73c 100644
>>>> --- a/drivers/pci/pci.h
>>>> +++ b/drivers/pci/pci.h
>>>> @@ -584,6 +584,9 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>>>>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>>>>  void pci_save_aspm_l1ss_state(struct pci_dev *dev);
>>>>  void pci_restore_aspm_l1ss_state(struct pci_dev *dev);
>>>> +void pcie_save_aspm_control(struct pci_dev *dev);
>>>> +void pcie_restore_aspm_control(struct pci_dev *dev);
>>>> +void pcie_disable_aspm(struct pci_dev *pdev);
>>>>  #else
>>>>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>>>>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>>>> @@ -591,6 +594,9 @@ static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>>>>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>>>>  static inline void pci_save_aspm_l1ss_state(struct pci_dev *dev) { }
>>>>  static inline void pci_restore_aspm_l1ss_state(struct pci_dev *dev) { }
>>>> +static inline void pcie_save_aspm_control(struct pci_dev *dev) { }
>>>> +static inline void pcie_restore_aspm_control(struct pci_dev *dev) { }
>>>> +static inline void pcie_disable_aspm(struct pci_dev *pdev) { }
>>>>  #endif
>>>>
>>>>  #ifdef CONFIG_PCIE_ECRC
>>>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>>>> index a08e7d6dc248..e1e97db32e8b 100644
>>>> --- a/drivers/pci/pcie/aspm.c
>>>> +++ b/drivers/pci/pcie/aspm.c
>>>> @@ -784,6 +784,33 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
>>>>                                        PCI_EXP_LNKCTL_ASPMC, val);
>>>>  }
>>>>
>>>> +void pcie_disable_aspm(struct pci_dev *pdev)
>>>> +{
>>>> +   if (!pci_is_pcie(pdev))
>>>> +           return;
>>>> +
>>>> +   pcie_config_aspm_dev(pdev, 0);
>>>> +}
>>>> +
>>>> +void pcie_save_aspm_control(struct pci_dev *pdev)
>>>> +{
>>>> +   u16 lnkctl;
>>>> +
>>>> +   if (!pci_is_pcie(pdev))
>>>> +           return;
>>>> +
>>>> +   pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &lnkctl);
>>>> +   pdev->saved_aspm_ctl = lnkctl & PCI_EXP_LNKCTL_ASPMC;
>>>> +}
>>>> +
>>>> +void pcie_restore_aspm_control(struct pci_dev *pdev)
>>>> +{
>>>> +   if (!pci_is_pcie(pdev))
>>>> +           return;
>>>> +
>>>> +   pcie_config_aspm_dev(pdev, pdev->saved_aspm_ctl);
>>>> +}
>>>> +
>>>>  static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>>>>  {
>>>>     u32 upstream = 0, dwstream = 0;
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index b32126d26997..a21bfd6e3f89 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -387,6 +387,7 @@ struct pci_dev {
>>>>     unsigned int    ltr_path:1;     /* Latency Tolerance Reporting
>>>>                                        supported from root to here */
>>>>     u16             l1ss;           /* L1SS Capability pointer */
>>>> +   u16             saved_aspm_ctl; /* ASPM Control saved at suspend time */
>>>>  #endif
>>>>     unsigned int    eetlp_prefix_path:1;    /* End-to-End TLP Prefix */
>>>>
>>>>
