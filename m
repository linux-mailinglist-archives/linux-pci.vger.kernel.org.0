Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DCE6689E7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 04:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAMDGa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 22:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjAMDGa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 22:06:30 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6AFDC7
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 19:06:28 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b3so31237048lfv.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 19:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6sI51ygEC0SqbBdTIprVPXmct2dLdDcxUGZ33HRjQCI=;
        b=DurtFcFk+nTqnqmFRNmrM66PXVi2yv4zgXQYeNW3fh9w3H/b0nZTTGHOxEwD7tuIeZ
         QbV2bZLr2J9OALbgUXAkFMR+VWMs0d3fzvAr2t6Ua7Bd7nHHDcFGdN/xpKmVepbFZXWQ
         HgaiD/OITDhdwFI3d8IWiB5IRo7bo3YR7Go6T+LAX6J9/39ZOGnjJEkJS4VdmSJgiJre
         zsKF/z4hb8N0nRjdShV3WbeDJWByuDQVj57CyFFYMWt1QuhUB+ieoNl0lcRCqoqJSkix
         U4A3HmopNkWX2TKLRWmbY5V5qdeua5yZlj5zQiudw8CsXAB3QmH7WL6ah1eJmKLoyNP9
         LPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sI51ygEC0SqbBdTIprVPXmct2dLdDcxUGZ33HRjQCI=;
        b=L2knRKQjz8dwrfZ9qirHF2aTkcuz6CE8eW5lXm/uERfVs3fkZW/dOtKDRR2C21EQue
         upEvyxWcs8j9mo4fDrtkKpnIqjba/aLc0GI1akdpe9KbQ5ChGwUxbp/xXAQLM12AX/Hf
         pSWC966P2lA7G8JQXVsv81U7QY4ikpGCVfKWUhcx5h0c8l6p2gbLk8Zq+4sO9asABX8t
         PTxtCsiigkt1SCSn5xzHHzu2Emv4k5v8hK5Yu+xAa28V2xrBxDUen4HzwXI95/wZ/CAf
         1UHbwcPtybOXdeldaJ+baarADY/5jNpRtsfsi8+yyxHHuUTxHlTqNDmybyci5aCHNpun
         dA3w==
X-Gm-Message-State: AFqh2kqvsCjdfO/HsTzFzgnnN7dEsoyviP/P+qiVriJmFpgwKCdpQJ9O
        dNQNGhCJyj3vFSM7ToS6lntnHOlMyQT4W8YJUoA=
X-Google-Smtp-Source: AMrXdXun1EGucqw2unnd+fZmF28Lgev11eHrX4jh8j1fN56ZPxYhLWUmbQyxgkblufFVsJRmU7QWxaRrhVco6ut1Tdg=
X-Received: by 2002:a05:6512:4014:b0:4b5:3f7f:f9ed with SMTP id
 br20-20020a056512401400b004b53f7ff9edmr3586742lfb.177.1673579186601; Thu, 12
 Jan 2023 19:06:26 -0800 (PST)
MIME-Version: 1.0
References: <20230112223533.GA1798809@bhelgaas> <15135d89-0515-d965-567b-79b3eca236e6@linux.alibaba.com>
In-Reply-To: <15135d89-0515-d965-567b-79b3eca236e6@linux.alibaba.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Thu, 12 Jan 2023 21:06:15 -0600
Message-ID: <CABhMZUWYxN0iuCJumGVH123E52L17Ow-De5FuX=bfDF3o6A_-A@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI/DPC: Await readiness of secondary bus after reset
To:     Yang Su <yang.su@linux.alibaba.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 8:39 PM Yang Su <yang.su@linux.alibaba.com> wrote:
>
> Hi Bjorn,
>
> This email is I discussed with Lukas previously, but now I found I forget=
 to CC you.
>
> I also test pci_bridge_wait_for_secondary_bus in NVIDIA GPU T4 which bind=
 vfio
>
> passthrough in VMM, I found the pci_bridge_wait_for_secondary_bus can not=
 wait
>
> the enough time as pci spec requires, the reasons are described as below.

Hi Yang,

When you're discussing Linux patches, please always keep the cc list
so the rest of us can see what's happening.  Also please use plain
ASCII email (not HTML, etc) because the list archives often discard
fancy emails.  Hints:

http://vger.kernel.org/majordomo-info.html
https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
https://people.kernel.org/tglx/notes-about-netiquette

I'll wait for you and Lukas to continue this conversation on the mailing li=
st.

Bjorn

> -------- =E8=BD=AC=E5=8F=91=E7=9A=84=E6=B6=88=E6=81=AF --------
> =E4=B8=BB=E9=A2=98: Re: [PATCH 2/3] PCI: Unify delay handling for reset a=
nd resume
> =E6=97=A5=E6=9C=9F: Wed, 4 Jan 2023 12:46:17 +0800
> From: Yang Su <yang.su@linux.alibaba.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Lukas Wunner <lukas@wunner.de>
>
>
> Hi Lukas,
>
> When some device such as NVIDIA GPU T4 bind vfio to passthrough in VMM, t=
he vfio will do reset for the divice, but some device
>
> such as NVIDIA GPU T4 only support secondary bus reset (SBR), and then wi=
ll call pci_reset_secondary_bus.
>
> The call path is below as figure shows,
>
>
> There are there reasons I think your modify for pci_reset_secondary_bus i=
s not ok.
>
> 1. As I describe for you, if the device not bridge call pci_reset_seconda=
ry_bus,
>
> the device will enter pci_bridge_wait_for_secondary_bus, but in pci_bridg=
e_wait_for_secondary_bus
>
> the device is not judged as pci bridge, will directly return.
>
> if (!pci_is_bridge(dev) || !dev->bridge_d3) {
>
> above code will do the judge.
>
>
> 2. In pci_bridge_wait_for_secondary_bus, pci_bus_max_d3cold_delay will ta=
ke count of wrong time delay,
>
> such as NVIDIA GPU T4 is not pci bridge, so the subordinate is none, pci_=
bus_max_d3cold_delay
>
> set the min_delay is 100, max_delay is 0, here is the bug, after list_for=
_each_entry() in pci_bus_max_d3cold_delay,
>
> the min_delay will be 0, the max_delay also 0, the pci_bus_max_d3cold_del=
ay return is surely 0.
>
>
> 3. pci_dev_wait must be saved, and cannot be replaced as pci_bridge_wait_=
for_secondary_bus.
>
> Because the pcie spec requires the device to check CRS, and pci_dev_wait =
do this thing.
>
> "
>
> Note: Software should use 100 ms wait periods only if software enables CR=
S Software Visibility.
>
> Otherwise, Completion timeouts, platform timeouts, or lengthy processor i=
nstruction stalls may result.
>
> See the Configuration Request Retry Status Implementation Note in Section=
 2.3.1.
>
> "
>
>
> void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
> {
>     struct pci_dev *child;
>     int delay;
>
>     if (pci_dev_is_disconnected(dev))
>         return;
>
>     if (!pci_is_bridge(dev) || !dev->bridge_d3)
>         return;
>
> ...
>
>     /* Take d3cold_delay requirements into account */
>     delay =3D pci_bus_max_d3cold_delay(dev->subordinate);
>
> }
>
>
>   void pci_reset_secondary_bus(struct pci_dev *dev)
> @@ -5058,15 +5060,6 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>
>   ctrl &=3D ~PCI_BRIDGE_CTL_BUS_RESET;
>   pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
> -
> - /*
> - * Trhfa for conventional PCI is 2^25 clock cycles.
> - * Assuming a minimum 33MHz clock this results in a 1s
> - * delay before we can consider subordinate devices to
> - * be re-initialized.  PCIe has some ways to shorten this,
> - * but we don't make use of them yet.
> - */
> - ssleep(1);
>   }
>
>   void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> @@ -5085,7 +5078,8 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *=
dev)
>   {
>   pcibios_reset_secondary_bus(dev);
>
> - return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
> + return pci_bridge_wait_for_secondary_bus(dev, "bus reset",
> + PCIE_RESET_READY_POLL_MS);
>   }
>
>
> =E5=9C=A8 2023/1/4 01:25, Lukas Wunner =E5=86=99=E9=81=93:
>
> Hi Yang Su!
>
> Thanks for reaching out.
>
> On Tue, Jan 03, 2023 at 07:45:25PM +0800, Yang Su wrote:
>
> I think your modify in pci_reset_secondary_bus is not ok. I test pci_brid=
ge_secondary_bus_reset used in pci_reset_secondary_bus,
> there will be an error is a device is not pci bridge device in pci_reset_=
secondary_buscall pci_bridge_secondary_bus_reset,
> pci_bridge_secondary_bus_reset judge the device is not pci bridge device =
and just return and will do nothing.
> So just use pci_bridge_secondary_bus_reset to replace ssleep(1) is not ok=
.
>
> Hm, I don't quite understand.
>
> How do you invoke pci_bridge_secondary_bus_reset() with a non-bridge devi=
ce?
> I followed all the code paths leading to pci_bridge_secondary_bus_reset()
> and it seems to me none of them is calling the function with an endpoint
> device.  What am I missing?
>
> Thanks,
>
> Lukas
>
> =E5=9C=A8 2023/1/13 06:35, Bjorn Helgaas =E5=86=99=E9=81=93:
>
> On Sat, Dec 31, 2022 at 07:33:39PM +0100, Lukas Wunner wrote:
>
> We're calling pci_bridge_wait_for_secondary_bus() after performing a
> Secondary Bus Reset, but neglect to do the same after coming out of a
> DPC-induced Hot Reset.  As a result, we're not observing the delays
> prescribed by PCIe r6.0 sec 6.6.1 and may access devices on the
> secondary bus before they're ready.  Fix it.
>
> Tested-by: Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>
>
> I assume this patch is the one that makes the difference for the
> Intel Ponte Vecchio HPC GPU?  Is there a URL to a problem report, or
> at least a sentence or two we can include here to connect the patch
> with the problem users may see?  Most people won't know how to
> recognize accesses to devices on the secondary bus before they're
> ready.
>
> Bjorn
