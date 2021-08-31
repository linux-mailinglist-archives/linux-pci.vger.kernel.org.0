Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA2C3FC09D
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 03:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbhHaCAk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 22:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbhHaCAj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Aug 2021 22:00:39 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D92C061575
        for <linux-pci@vger.kernel.org>; Mon, 30 Aug 2021 18:59:45 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1630375182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lyhxQigXdSSToOuQU47jFer9fZBq96dKWurAhRLk83M=;
        b=VZ8dKRWzDN/mQ2BXPpCIP/BZfgOFgkl1CHL7sG0qUkP7Tyt1RZr6Qt/1128/ACBO5E+oyP
        0tBWkpyzQa6yAiizlOZwxsiQ+2daOKJBUnk6+m0CS7eFGPuYrzfEjGKaa5+ntDqzcV5KH4
        gc2S6RDhjabpnAmUuliki/jtvr+IbeQ=
Date:   Tue, 31 Aug 2021 01:59:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   jonathan.derrick@linux.dev
Message-ID: <a23b21724b9dc31bb0c4f16207f280c8@linux.dev>
Subject: Re: [PATCH v3] PCI: pciehp: Add quirk to handle spurious DLLSC on
 a x4x4 SSD
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     linux-pci@vger.kernel.org, "Bjorn Helgaas" <helgaas@kernel.org>,
        "Lukas Wunner" <lukas@wunner.de>,
        "James Puthukattukaran" <james.puthukattukaran@oracle.com>,
        "Jon Derrick" <jonathan.derrick@intel.com>
In-Reply-To: <20210830174637.GA163187@otc-nc-03>
References: <20210830174637.GA163187@otc-nc-03>
 <20210830155628.130054-1-jonathan.derrick@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: jonathan.derrick@linux.dev
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ashok=0A=0AAugust 30, 2021 12:46 PM, "Raj, Ashok" <ashok.raj@intel.com=
> wrote:=0A=0A> Hi Jonathan=0A> =0A> Looks mostly good. Thanks for the up=
date. Reads better, but I'm still a bit=0A> confused .. sorry=0A> =0A> On=
 Mon, Aug 30, 2021 at 09:56:28AM -0600, Jon Derrick wrote:=0A> =0A>> From=
: James Puthukattukaran <james.puthukattukaran@oracle.com>=0A>> =0A>> Whe=
n an Intel P5608 SSD is bifurcated into x4x4 mode, and the upstream=0A>> =
ports both support hotplugging on each respective x4 device, a slot=0A>> =
management system for the SSD requires both x4 slots to have power=0A>> r=
emoved via sysfs (echo 0 > slot/N/power), from the OS before it can=0A>> =
safely turn-off physical power for the whole x8 device. The implications=
=0A>> are that slot status will display powered off and link inactive sta=
tuses=0A>> for the x4 devices where the devices are actually powered unti=
l both=0A>> ports have powered off.=0A> =0A> This part is a bit muddy bas=
ed on the description in the following writeup.=0A> =0A> slot1->power off=
->link1 DOWN (Should fire a DLLSC event?) or does the link=0A> stay activ=
e until slot2 is powered off?=0A=0AInternal link is active but link is=0A=
presented as down in the slot status register=0A=0A=0A> =0A> slot2->power=
 off, looks like only now link1 is getting DLLSC which you are=0A> ignori=
ng skipping to make sure you don't turn this into an ON event.=0A=0AI thi=
nk the dllsc on slot 1 occurs when the=0Awhole complex powers down after =
both slots=0Aare powered-off=0A=0A=0A=0A> =0A> slot2 will also receive DL=
LSC, and you would ignore it also for the same=0A> reasons.=0A> =0A> Mayb=
e this was discussed earlier and I didn't catch it.=0A> When in OFF-state=
, and DLLSC is received but link is down while in OFF state,=0A> shoudn't=
 that be the default handling? It almost looks like its a spurious=0A> DL=
LSC event that can be ignored for all cases without a specific quirk?=0A>=
 =0A> Or is there a case we care about for normal devices?=0A=0ALukas pre=
sented a possible race [1] with a=0Aspurious surprise hotplug where you c=
ould be=0Ain off state and link is still inactive,=0Aexpecting the state =
machine to power on the slot.=0A=0AThis is avoided in this SSD because th=
e=0Aindividual slots in the complex won=E2=80=99t be=0Asurprise hotplugge=
d, avoiding spurious=0Aevents.=0A=0A[1] https://lore.kernel.org/linux-pci=
/20210525192512.GA3450@wunner.de/=0A=0A=0A> =0A>> The issue with the SSD =
manifests when power is removed from the=0A>> first-half and then the sec=
ond-half. During the first-half removal, slot=0A>> status shows the slot =
as powered-down and link-inactive, while internal=0A>> power and link rem=
ain active while waiting for the second-half to have=0A>> power removed. =
When power is then removed from the second-half, the=0A>> first-half star=
ts shutdown sequence and will trigger a DLLSC event. This=0A>> is misinte=
rpreted as an enabling event and causes the first-half to be=0A>> re-enab=
led.=0A> =0A> Question is:=0A> =0A> when slot1 is powered off, do you get=
 a DLLSC for that link that reports=0A> link_down? or does external link =
still report UP until both ports are=0A> powered off?=0AAs far as the ker=
nel knows by checking the=0Aslot status register, the link is inactive.=
=0AInternally to the complex, link is still=0Aactive until both slots are=
 powered off.=0A=0AIt=E2=80=99s the powering off of the whole complex=0At=
hat causes slot 1 to throw dllsc, where=0Ainternally slot 1 is going from=
 active to=0Ainactive, and externally the kernel sees it=0Astaying inacti=
ve.=0A=0A=0A> =0A>> The spurious enable can be resolved by ignoring link =
status change=0A>> events when no link is active when in the off state. T=
his patch adds a=0A>> quirk for specific P5608 SSDs which have been teste=
d for compatibility.=0A>> =0A>> Signed-off-by: Jon Derrick <jonathan.derr=
ick@intel.com>=0A>> Signed-off-by: James Puthukattukaran <james.puthukatt=
ukaran@oracle.com>=0A>> ---=0A>> v2->v3: Clarified commit message and com=
ment block=0A>> Added second supported subdevice ID=0A>> Added hotplug if=
def blocks=0A>> =0A>> drivers/pci/hotplug/pciehp_ctrl.c | 7 +++++++=0A>> =
drivers/pci/quirks.c | 34 +++++++++++++++++++++++++++++++=0A>> include/li=
nux/pci.h | 1 +=0A>> 3 files changed, 42 insertions(+)=0A>> =0A>> diff --=
git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl=
.c=0A>> index 529c34808440..db41f78bfac8 100644=0A>> --- a/drivers/pci/ho=
tplug/pciehp_ctrl.c=0A>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c=0A>> @@ =
-225,6 +225,7 @@ void pciehp_handle_disable_request(struct controller *ct=
rl)=0A>> void pciehp_handle_presence_or_link_change(struct controller *ct=
rl, u32 events)=0A>> {=0A>> int present, link_active;=0A>> + struct pci_d=
ev *pdev =3D ctrl->pcie->port;=0A>> =0A>> /*=0A>> * If the slot is on and=
 presence or link has changed, turn it off.=0A>> @@ -265,6 +266,12 @@ voi=
d pciehp_handle_presence_or_link_change(struct controller *ctrl, u32=0A>>=
 events)=0A>> cancel_delayed_work(&ctrl->button_work);=0A>> fallthrough;=
=0A>> case OFF_STATE:=0A>> + if (pdev->shared_pcc_and_link_slot &&=0A>> +=
 (events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {=0A>> + mutex_unlock(&=
ctrl->state_lock);=0A>> + break;=0A>> + }=0A>> +=0A>> ctrl->state =3D POW=
ERON_STATE;=0A>> mutex_unlock(&ctrl->state_lock);=0A>> if (present)=0A>> =
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c=0A>> index 10122=
e3318cf..c6b48ddc5c3d 100644=0A>> --- a/drivers/pci/quirks.c=0A>> +++ b/d=
rivers/pci/quirks.c=0A>> @@ -5750,3 +5750,37 @@ static void apex_pci_fixu=
p_class(struct pci_dev *pdev)=0A>> }=0A>> DECLARE_PCI_FIXUP_CLASS_HEADER(=
0x1ac1, 0x089a,=0A>> PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);=0A>=
> +=0A>> +#ifdef CONFIG_HOTPLUG_PCI_PCIE=0A>> +/*=0A>> + * This is an Int=
el NVMe SSD which sits in a x8 pciehp slot but is bifurcated=0A>> + * as =
a x4x4 and manifests as two slots with respect to PCIe hot plug register=
=0A>> + * states. However, the hotplug controller treats these slots as a=
 single x8=0A>> + * slot for link and power. Either one of the two slots =
can be powered down=0A>> + * separately and the slot status will show neg=
ative power and link states, but=0A>> + * internal power and link will be=
 active until the last of the two slots is=0A>> + * powered down. When th=
e last of the two x4 slots is turned off, power and=0A>> + * link will be=
 turned off for the x8 slot by the HP controller. This=0A>> + * configura=
tion causes some interesting behavior in bringup sequence=0A>> + *=0A>> +=
 * When the second slot is powered off to remove the card, this will caus=
e the=0A>> + * link to go down for both x4 slots. So, the x4 that is alre=
ady powered down=0A>> + * earlier will see a DLLSC event and attempt to b=
ring itself up (card present,=0A>> + * link change event, link state is d=
own). Special handling is required in=0A>> + * pciehp_handle_presence_or_=
link_change to prevent this unintended bring up=0A>> + */=0A>> +static vo=
id quirk_shared_pcc_and_link_slot(struct pci_dev *pdev)=0A>> +{=0A>> + st=
ruct pci_dev *parent =3D pci_upstream_bridge(pdev);=0A>> +=0A>> + if (par=
ent && pdev->subsystem_vendor =3D=3D 0x108e) {=0A>> + switch (pdev->subsy=
stem_device) {=0A>> + /* P5608 */=0A>> + case 0x487d:=0A>> + case 0x488d:=
=0A>> + parent->shared_pcc_and_link_slot =3D 1;=0A>> + }=0A>> + }=0A>> +}=
=0A>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x0b60, quirk_shared_=
pcc_and_link_slot);=0A>> +#endif /* CONFIG_HOTPLUG_PCI_PCIE */=0A>> diff =
--git a/include/linux/pci.h b/include/linux/pci.h=0A>> index 7ed95f11c6bd=
..bcef73209487 100644=0A>> --- a/include/linux/pci.h=0A>> +++ b/include/l=
inux/pci.h=0A>> @@ -463,6 +463,7 @@ struct pci_dev {=0A>> =0A>> #ifdef CO=
NFIG_HOTPLUG_PCI_PCIE=0A>> unsigned int broken_cmd_compl:1; /* No compl f=
or some cmds */=0A>> + unsigned int shared_pcc_and_link_slot:1;=0A>> #end=
if=0A>> #ifdef CONFIG_PCIE_PTM=0A>> unsigned int ptm_root:1;=0A>> --=0A>>=
 2.27.0=0A> =0A> --=0A> Cheers,=0A> Ashok
