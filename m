Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D2D6AA92C
	for <lists+linux-pci@lfdr.de>; Sat,  4 Mar 2023 11:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCDKes (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Mar 2023 05:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCDKer (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Mar 2023 05:34:47 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101D910AB8;
        Sat,  4 Mar 2023 02:34:45 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.108.20.84])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id BF00C20CD4;
        Sat,  4 Mar 2023 10:34:40 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Sat, 4 Mar
 2023 11:34:39 +0100
Message-ID: <7fa7f07f-d1e1-1e43-992c-4981c5810284@traphandler.com>
Date:   Sat, 4 Mar 2023 11:34:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/3] of: irq: make callers of of_irq_parse_one() release
 the device node
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <saravanak@google.com>, <clement.leger@bootlin.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        <zajec5@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marc Zyngier <maz@kernel.org>, <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nishanth Menon <nm@ti.com>, <ssantosh@kernel.org>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-wireless@vger.kernel.org>,
        <linux-actions@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <20230301185209.274134-1-jjhiblot@traphandler.com>
 <20230301185209.274134-3-jjhiblot@traphandler.com>
 <CAMuHMdVF337k+zyjpbzoDtWWDnYhM6eM3+As6UuZ7FCgASsMQg@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAMuHMdVF337k+zyjpbzoDtWWDnYhM6eM3+As6UuZ7FCgASsMQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: CAS2.emp2.local (172.16.1.2) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 2216615445481994549
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvddtuddgudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthekredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepvdefkedugeekueeuvdeuueevjefftddvtefhleekhfefffdtteetffeigfdvtdeinecukfhppeduvdejrddtrddtrddupdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdpsghhvghlghgrrghssehgohhoghhlvgdrtghomhdpnhhmsehtihdrtghomhdpshhsrghnthhoshhhsehkvghrnhgvlhdrohhrghdpmhgrthhhihgrshdrnhihmhgrnhesihhnthgvlhdrtghomhdpghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhthhhivghrrhihrdhrvgguihhnghesghhmrghilhdrtghomhdpjhhonhgrthhhrg
 hnhhesnhhvihguihgrrdgtohhmpdhlihhnuhigqdhrvghnvghsrghsqdhsohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhlihhnuhigqdifihhrvghlvghsshesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqrggtthhiohhnsheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdplhhinhhugidqrhhishgtvheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdplhhinhhugidqshhunhigiheslhhishhtshdrlhhinhhugidruggvvhdpuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhfrhhofigrnhgurdhlihhsthesghhmrghilhdrtghomhdplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhhosghhodgutheskhgvrhhnvghlrdhorhhgpdhjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdpshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdgtlhgvmhgvnhhtrdhlvghgvghrsegsohhothhlihhnrdgtohhmpdhmrghgnhhushdruggrmhhmsehgmhgrihhlrdgtohhmpdhlihhnuhigsegrrhhmlhhinhhugid
 rohhrghdruhhkpdhmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdpnhhpihhgghhinhesghhmrghilhdrtghomhdptghhrhhishhtohhphhgvrdhlvghrohihsegtshhgrhhouhhprdgvuhdpiigrjhgvtgehsehgmhgrihhlrdgtohhmpdgurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhtghhlgieslhhinhhuthhrohhnihigrdguvgdptghlrghuughiuhdrsggviihnvggrsehmihgtrhhotghhihhprdgtohhmpdhmrgiisehkvghrnhgvlhdrohhrghdprghfrggvrhgsvghrsehsuhhsvgdruggvpdhmrghniheskhgvrhhnvghlrdhorhhgpdhprghlmhgvrhesuggrsggsvghlthdrtghomhdpphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdifvghnshestghsihgvrdhorhhgpdhsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgpdhlihhnuhigqdhtvghgrhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehvdekpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 02/03/2023 08:49, Geert Uytterhoeven wrote:
> Hi Jean-Jacques,
> 
> Thanks for your patch!
> 
> On Wed, Mar 1, 2023 at 7:53 PM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> of_irq_parse_one() does a get() on the device node returned in out_irq->np.
>> Callers of of_irq_parse_one() must do a put() when they are done with it.
> 
> What does "be done with it" really mean here?
> 
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> 
>> --- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
>> +++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
>> @@ -184,6 +184,7 @@ static int __init rcar_gen2_regulator_quirk(void)
>>                          kfree(quirk);
>>                          continue;
>>                  }
>> +               of_node_put(argsa->np);
> 
> The quirk object, which is a container of argsa, is still used below,
> and stored in a linked list.  I agree argsa->np is not dereferenced,
> but the pointer itself is still compared to other pointers.
Hi Geert,

I fail to see when the pointers are compared. It looks to me that only 
the args are compared. Am I missing something ?
In any case, looking more closely at the code, I guess that indeed the
of_node_put() shouldn't be added here because this code expects that the
nodes never go away. That is probably a good assertion in case of PMICs

JJ
> IIUIC, calling of_node_put() might cause the reference count to drop to
> zero, and the underlying struct node object to be deallocated.
> So when a future reference to the same DT node will be taken, a new
> struct node object will be allocated, and the pointer comparison below
> will fail?
> 
> Or am I missing something?
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
