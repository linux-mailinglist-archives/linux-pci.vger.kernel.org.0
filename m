Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B2113EDF
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2019 10:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfLEJ6H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Dec 2019 04:58:07 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6176 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbfLEJ6H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2019 04:58:07 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de8d49d0000>; Thu, 05 Dec 2019 01:57:49 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Dec 2019 01:58:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Dec 2019 01:58:05 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Dec
 2019 09:58:04 +0000
Received: from [10.25.73.84] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Dec 2019
 09:57:59 +0000
Subject: Re: [PATCH 2/6] dt-bindings: PCI: tegra: Add DT support for PCIe EP
 nodes in Tegra194
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
References: <20191122104505.8986-1-vidyas@nvidia.com>
 <20191122104505.8986-3-vidyas@nvidia.com> <20191122131931.GB1315704@ulmo>
 <8fbdda8e-84af-576c-e240-61c381c85a8f@nvidia.com>
 <20191125073359.GD1409040@ulmo>
 <DM6PR12MB401074B85B9E9E592648FF65DA4A0@DM6PR12MB4010.namprd12.prod.outlook.com>
 <b9e8e8cc-2d05-cab7-4fd8-34c3c835bf92@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <39619170-117d-2504-4816-ff40c398ec36@nvidia.com>
Date:   Thu, 5 Dec 2019 15:27:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b9e8e8cc-2d05-cab7-4fd8-34c3c835bf92@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575539869; bh=AW82+JLzOUNe9WDEexBN1WZ5qLWqQXJ11zyeLMODOYI=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SuOnMkXQXv67GD6C7t0Wg9+G6ZfjiB4l/UQPj+SPAb+jNayBW3EqA9uK79yFI8ZpC
         b2lAxdUZeLdkwI/6DNrOMCJZUQD6smqoxM9IVTVWiayc7lEAxrnSnj865B5iWNTM5A
         WTK/l9oTTy6FVMWGeGNEr/9dym19N515tbd60Xc7aw5D8mx12WcfXQefqhGR9CX+VC
         UY3LwD+6uAxKhRg5Cxi3bq61lTMNIB3uLZMymjZtYq/tUb+6wgu3G1mbxcDK5ReZqe
         /uSWHGnQS76b3l/u5S9dZxQG4X7rGGo620OYwBO3ObUkmuRmQYm5DIMV2ZoP+rGVeH
         3meBiagqLemqw==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/29/2019 6:56 PM, Vidya Sagar wrote:

Rob, Can you please update your comments on this?

Thanks,
Vidya Sagar

> On 11/25/2019 5:22 PM, Gustavo Pimentel wrote:
>> On Mon, Nov 25, 2019 at 7:33:59, Thierry Reding
>> <thierry.reding@gmail.com> wrote:
>>
>>> On Mon, Nov 25, 2019 at 12:53:42PM +0530, Vidya Sagar wrote:
>>>> On 11/22/2019 6:49 PM, Thierry Reding wrote:
>>>>> On Fri, Nov 22, 2019 at 04:15:01PM +0530, Vidya Sagar wrote:
>>>>>> Add support for PCIe controllers that can operate in endpoint mode
>>>>>> in Tegra194.
>>>>>>
>>>>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>>>>> ---
>>>>>> =C2=A0=C2=A0 .../bindings/pci/nvidia,tegra194-pcie-ep.txt=C2=A0 | 13=
8 ++++++++++++++++++
>>>>>> =C2=A0=C2=A0 1 file changed, 138 insertions(+)
>>>>>> =C2=A0=C2=A0 create mode 100644 Documentation/devicetree/bindings/pc=
i/nvidia,tegra194-pcie-ep.txt
>>>>>
>>>>> The vast majority of this is a duplication of the host mode device tr=
ee
>>>>> bindings. I think it'd be best to combine both and only highlight whe=
re
>>>>> both modes differ.
>>>>>
>>>>> The designware-pcie.txt binding does something similar.
>>>> Ok. I'll merge this into the host mode bindings file and in that diffe=
rentiate between
>>>> root mode and endpoint mode.
>>>>
>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-p=
cie-ep.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.=
txt
>>>>>> new file mode 100644
>>>>>> index 000000000000..4676ccf7dfa5
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.=
txt
>>>>>> @@ -0,0 +1,138 @@
>>>>>> +NVIDIA Tegra PCIe Endpoint mode controller (Synopsys DesignWare Cor=
e based)
>>>>>> +
>>>>>> +Some of the PCIe controllers which are based on Synopsys DesignWare=
 PCIe IP
>>>>>> +are dual mode i.e. they can work in root port mode or endpoint mode=
 but one
>>>>>> + at a time. Since they are based on DesignWare IP, they inherit all=
 the common
>>>>>> +properties defined in designware-pcie.txt.
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
>>>>>
>>>>> The device tree snippets that you added have "nvidia,tegra194-pcie-ep=
"
>>>>> for EP mode controllers. So either this is wrong or the DTS files are
>>>>> wrong.
>>>> DTS file are correct. This is a mistake in this file. I'll correct thi=
s.
>>>>
>>>>>
>>>>> This device tree binding describes the exact same hardware, so I don'=
t
>>>>> think we necessarily need two different compatible strings. It's fair=
ly
>>>>> easy to distinguish between which mode to run in by looking at which
>>>>> properties exist. EP mode for example is the only one that uses the
>>>>> "addr_space" reg entry.
>>>>>
>>>>> Rob, do you know why a different compatible string was chosen for the=
 EP
>>>>> mode? Looking at the driver, there are only a handful of differences =
in
>>>>> the programming, but most of the driver remains identical. An extra D=
T
>>>>> compatible string seems a bit exaggerated since it suggests that this=
 is
>>>>> actually different hardware, where it clearly isn't.
>>>> Since all other implementations have done it this way, I just followed=
 to be in sync
>>>> with them. Even I would also like to hear from Rob on the rationale be=
hind this.
> Rob, Could you please update on this?
>=20
>>>>
>>>>>
>>>>>> +=C2=A0 Tegra194: Only C0, C4 & C5 controllers are dual mode control=
lers.
>>>>>> +- power-domains: A phandle to the node that controls power to the r=
espective
>>>>>> +=C2=A0 PCIe controller and a specifier name for the PCIe controller=
. Following are
>>>>>> +=C2=A0 the specifiers for the different PCIe controllers
>>>>>> +=C2=A0=C2=A0=C2=A0 TEGRA194_POWER_DOMAIN_PCIEX8B: C0
>>>>>> +=C2=A0=C2=A0=C2=A0 TEGRA194_POWER_DOMAIN_PCIEX4A: C4
>>>>>> +=C2=A0=C2=A0=C2=A0 TEGRA194_POWER_DOMAIN_PCIEX8A: C5
>>>>>> +=C2=A0 these specifiers are defined in
>>>>>> +=C2=A0 "include/dt-bindings/power/tegra194-powergate.h" file.
>>>>>> +- reg: A list of physical base address and length pairs for each se=
t of
>>>>>> +=C2=A0 controller registers. Must contain an entry for each entry i=
n the reg-names
>>>>>> +=C2=A0 property.
>>>>>> +- reg-names: Must include the following entries:
>>>>>> +=C2=A0 "appl": Controller's application logic registers
>>>>>> +=C2=A0 "atu_dma": iATU and DMA registers. This is where the iATU (i=
nternal Address
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Translation Unit) registers of the PCIe core are made available
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 for SW access.
>>>>>> +=C2=A0 "dbi": The aperture where root port's own configuration regi=
sters are
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 available
>>>>>> +=C2=A0 "addr_space": Used to map remote RC address space
>>>>>> +- interrupts: A list of interrupt outputs of the controller. Must c=
ontain an
>>>>>> +=C2=A0 entry for each entry in the interrupt-names property.
>>>>>> +- interrupt-names: Must include the following entry:
>>>>>> +=C2=A0 "intr": The Tegra interrupt that is asserted for controller =
interrupts
>>>>>> +- clocks: Must contain an entry for each entry in clock-names.
>>>>>> +=C2=A0 See ../clocks/clock-bindings.txt for details.
>>>>>> +- clock-names: Must include the following entries:
>>>>>> +=C2=A0 - core
>>>>>> +- resets: Must contain an entry for each entry in reset-names.
>>>>>> +=C2=A0 See ../reset/reset.txt for details.
>>>>>> +- reset-names: Must include the following entries:
>>>>>> +=C2=A0 - apb
>>>>>> +=C2=A0 - core
>>>>>> +- phys: Must contain a phandle to P2U PHY for each entry in phy-nam=
es.
>>>>>> +- phy-names: Must include an entry for each active lane.
>>>>>> +=C2=A0 "p2u-N": where N ranges from 0 to one less than the total nu=
mber of lanes
>>>>>> +- nvidia,bpmp: Must contain a pair of phandle to BPMP controller no=
de followed
>>>>>> +=C2=A0 by controller-id. Following are the controller ids for each =
controller.
>>>>>> +=C2=A0=C2=A0=C2=A0 0: C0
>>>>>> +=C2=A0=C2=A0=C2=A0 4: C4
>>>>>> +=C2=A0=C2=A0=C2=A0 5: C5
>>>>>> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
>>>>>> +- nvidia,pex-rst-gpio: Must contain a phandle to a GPIO controller =
followed by
>>>>>> +=C2=A0 GPIO that is being used as PERST signal
>>>>>
>>>>> Why is this NVIDIA specific? Do other instantiations of the DW IP not
>>>>> also need a means to define which GPIO is the reset?
>>>> I'm not sure. At least I didn't find anything like this in other imple=
mentations.
>>>> My understanding is that, controller handles assert/de-assert on the P=
ERST line
>>>> automatically without SW intervention. I think it is for the same reas=
on that other
>>>> implementations don't wait for the REFCLK to flow in from host to conf=
igure the IP.
>>>> I think they just use some internal clock for the configuration and sw=
itch to
>>>> running the core based on REFCLK as and when it is available
>>>> (i.e. whenever a de-assert is perceived on PERST line by the controlle=
r)
>>>
>>> That would be somewhat surprising, though. The IP used in Tegra must be
>>> pretty close to the IP used in other SoCs, and the code that we need in
>>> pex_ep_event_pex_rst_{assert,deassert}() is pretty significant. Why the
>>> other instantiations wouldn't need something similar seems unlikely to
>>> me.
>>>
>>> Perhaps Jingoo or Gustavo can shed some light on this.
>>
>> On my current FPGA prototyping solution, I don't need to control the
>> PERST line and it's very likely that I don't even have access to control
>> it. I guess due to some particularity of my solution, the HW team
>> probably has decided to wire it up directly for some unknown reason to
>> me.
>>
>> However, It seems to me that exynos, imx6, keystone, meson, al, histb,
>> kirin, and qcom drivers controls the PERST line in spite of others drive=
r
>> that doesn't do it like in my prototype solution.
>> In the end I'd says that depends of how the IP solution of design by the
>> HW team.
>>
>> Gustavo
>>
>>>
>>> Thierry
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +Optional properties:
>>>>>> +- pinctrl-names: A list of pinctrl state names.
>>>>>> +=C2=A0 It is mandatory for C5 controller and optional for other con=
trollers.
>>>>>> +=C2=A0 - "default": Configures PCIe I/O for proper operation.
>>>>>> +- pinctrl-0: phandle for the 'default' state of pin configuration.
>>>>>> +=C2=A0 It is mandatory for C5 controller and optional for other con=
trollers.
>>>>>> +- supports-clkreq: Refer to Documentation/devicetree/bindings/pci/p=
ci.txt
>>>>>> +- nvidia,update-fc-fixup: This is a boolean property and needs to b=
e present to
>>>>>> +=C2=A0=C2=A0=C2=A0 improve performance when a platform is designed =
in such a way that it
>>>>>> +=C2=A0=C2=A0=C2=A0 satisfies at least one of the following conditio=
ns thereby enabling root
>>>>>> +=C2=A0=C2=A0=C2=A0 port to exchange optimum number of FC (Flow Cont=
rol) credits with
>>>>>> +=C2=A0=C2=A0=C2=A0 downstream devices
>>>>>> +=C2=A0=C2=A0=C2=A0 1. If C0/C4/C5 run at x1/x2 link widths (irrespe=
ctive of speed and MPS)
>>>>>> +=C2=A0=C2=A0=C2=A0 2. If C0/C4/C5 operate at their respective max l=
ink widths and
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a) speed is Gen-2 and MPS is 2=
56B
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b) speed is >=3D Gen-3 with an=
y MPS
>>>>>> +- nvidia,aspm-cmrt-us: Common Mode Restore Time for proper operatio=
n of ASPM
>>>>>> +=C2=A0=C2=A0 to be specified in microseconds
>>>>>> +- nvidia,aspm-pwr-on-t-us: Power On time for proper operation of AS=
PM to be
>>>>>> +=C2=A0=C2=A0 specified in microseconds
>>>>>> +- nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to=
 be
>>>>>> +=C2=A0=C2=A0 specified in microseconds
>>>>>> +
>>>>>> +NOTE:- On Tegra194's P2972-0000 platform, only C5 controller can be=
 enabled to
>>>>>> +operate in the endpoint mode because of the way the platform is des=
igned.
>>>>>> +There is a mux that needs to be programmed to let the REFCLK from t=
he host to
>>>>>> +flow into C5 controller when it operates in the endpoint mode. This=
 mux is
>>>>>> +controlled by the GPIO (AA, 5) and it needs to be driven 'high'. Fo=
r this to
>>>>>> +happen, set status of "pex-refclk-sel-high" node under "gpio@c2f000=
0" node to
>>>>>> +'okay'.
>>>>>> +=C2=A0=C2=A0=C2=A0 When any dual mode controller is made to operate=
 in the endpoint mode,
>>>>>> +please make sure that its respective root port node's status is set=
 to
>>>>>> +'disabled'.
>>>>>
>>>>> This seems very brittle to me. There's no good way how we can detect
>>>>> such misconfigurations. If instead we only have one node describing t=
he
>>>>> hardware fully, the chances of configuring things wrong (by for examp=
le
>>>>> enabling both the host and EP mode device tree nodes) can be reduced.
>>>>>
>>>>> So I think instead of duplicating all of the device tree content to h=
ave
>>>>> both a host and an EP node for each controller, it'd be better to jus=
t
>>>>> have a single node and let the device tree bindings specify which
>>>>> changes to apply to switch into EP mode.
>>>>>
>>>>> For example, there should be nothing wrong with specifying some of th=
e
>>>>> EP-only properties (like num-ib-windows and num-ob-windows) all the t=
ime
>>>>> and only use them when we actually run in EP mode.
>>>>>
>>>>> As I mentioned earlier, there are a couple of easy ways to distinguis=
h
>>>>> the modes. The presence of the "addr_space" reg entry is one example,
>>>>> but we could also key off the nvidia,pex-rst-gpio property, since tha=
t
>>>>> (presumably) wouldn't be needed for host mode.
>>>>>
>>>>> That way we can just add default, host mode entries to tegra194.dtsi =
and
>>>>> whenever somebody wants to enable EP mode, they can just override the
>>>>> node in the board-level DTS file, like so:
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0pcie@141a0000 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x00 0x141a0000 0=
x0 0x00020000=C2=A0=C2=A0 /* appl registers (128K)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x00 0x3a040000 0x0 0x00040000=C2=A0=C2=A0 /* iATU_DMA reg =
space (256K)=C2=A0 */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x00 0x3a080000 0x0 0x00040000=C2=A0=C2=A0 /* DBI reg space=
 (256K)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg-names =3D "appl", "atu=
_dma", "dbi", "addr_space";
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvidia,pex-rst-gpio =3D <&=
gpio TEGRA194_MAIN_GPIO(GG, 1) GPIO_ACTIVE_LOW>;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0};
>>>>>
>>>>> Thierry
>>>> I like it and fine with making these modifications also but would like=
 to hear from Rob
>>>> also on this.
>>>>
>>>> - Vidya Sagar
>>>>>
>>>>>> +
>>>>>> +Examples:
>>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>> +
>>>>>> +Tegra194:
>>>>>> +--------
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 pcie_ep@141a0000 {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "nvidia,t=
egra194-pcie-ep", "snps,dw-pcie-ep";
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 power-domains =3D <&bpmp=
 TEGRA194_POWER_DOMAIN_PCIEX8A>;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x00 0x141a0000=
 0x0 0x00020000=C2=A0=C2=A0 /* appl registers (128K)=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x00 0x3a040000 0x0 0x00040000=C2=A0=C2=A0 /* iATU_DMA r=
eg space (256K)=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x00 0x3a080000 0x0 0x00040000=C2=A0=C2=A0 /* DBI reg sp=
ace (256K)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg-names =3D "appl", "a=
tu_dma", "dbi", "addr_space";
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num-lanes =3D <8>;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num-ib-windows =3D <2>;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 num-ob-windows =3D <8>;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "defau=
lt";
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&clkreq_c=
5_bi_dir_state>;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&bpmp TEGRA1=
94_CLK_PEX1_CORE_5>;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names =3D "core";
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resets =3D <&bpmp TEGRA1=
94_RESET_PEX1_CORE_5_APB>,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reset-names =3D "apb", "=
core";
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupts =3D <GIC_SPI =
53 IRQ_TYPE_LEVEL_HIGH>;=C2=A0=C2=A0=C2=A0 /* controller interrupt */
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 interrupt-names =3D "int=
r";
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvidia,bpmp =3D <&bpmp 5=
>;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvidia,aspm-cmrt-us =3D =
<60>;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvidia,aspm-pwr-on-t-us =
=3D <20>;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvidia,aspm-l0s-entrance=
-latency-us =3D <3>;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vddio-pex-ctl-supply =3D=
 <&vdd_1v8ao>;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nvidia,pex-rst-gpio =3D =
<&gpio TEGRA194_MAIN_GPIO(GG, 1)
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPIO_ACTIVE_LOW>;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phys =3D <&p2u_nvhs_0>, =
<&p2u_nvhs_1>, <&p2u_nvhs_2>,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 <&p2u_nvhs_6>, <&p2u_nvhs_7>;
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 phy-names =3D "p2u-0", "=
p2u-1", "p2u-2", "p2u-3", "p2u-4",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "p2u-5", "p2u-6", "p2u-7";
>>>>>> +=C2=A0=C2=A0=C2=A0 };
>>>>>> --=20
>>>>>> 2.17.1
>>>>>>
>>>>
>>
>>
>=20

