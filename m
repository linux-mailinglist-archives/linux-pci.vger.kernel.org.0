Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DE06A7780
	for <lists+linux-pci@lfdr.de>; Thu,  2 Mar 2023 00:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCAXE2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Mar 2023 18:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjCAXE1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 18:04:27 -0500
X-Greylist: delayed 71 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Mar 2023 15:04:17 PST
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AEB4BEAF;
        Wed,  1 Mar 2023 15:04:17 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.156.120])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 694A92195F;
        Wed,  1 Mar 2023 18:52:58 +0000 (UTC)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 1 Mar
 2023 19:52:57 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <saravanak@google.com>, <clement.leger@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-wireless@vger.kernel.org>,
        <linux-actions@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [PATCH 0/3] of: irq: Fixes refcount issues with of_irq_parse_one()/of_irq_parse_raw()
Date:   Wed, 1 Mar 2023 19:52:06 +0100
Message-ID: <20230301185209.274134-1-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 11460535153186650492
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudelhedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeejuefhkeelgffhlefhtefhgeektdevvdfgkeeltdehgeeujeeutdehkeeuhffftdenucfkphepuddvjedrtddrtddruddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhnmhesthhirdgtohhmpdhsshgrnhhtohhshheskhgvrhhnvghlrdhorhhgpdhmrghthhhirghsrdhnhihmrghnsehinhhtvghlrdgtohhmpdhgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdpthhhihgvrhhrhidrrhgvughinhhgsehgmhgrihhlrdgtohhmpdhjohhnrghthhgrnhhhsehnvhhiughirgdrtghomhdplhhinhhugidqrh
 gvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdgrtghtihhonhhssehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhlihhnuhigqdhsuhhngihisehlihhsthhsrdhlihhnuhigrdguvghvpdguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpsghhvghlghgrrghssehgohhoghhlvgdrtghomhdpfhhrohifrghnugdrlhhishhtsehgmhgrihhlrdgtohhmpdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpshgrmhhuvghlsehshhholhhlrghnugdrohhrghdptghlvghmvghnthdrlhgvghgvrhessghoohhtlhhinhdrtghomhdpghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdpmhgrghhnuhhsrdgurghmmhesghhmrghilhdrtghomhdplhhinhhugiesrghrmhhlihhnuhigrdhorhh
 grdhukhdpmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhnphhighhgihhnsehgmhgrihhlrdgtohhmpdgthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdiirghjvggtheesghhmrghilhdrtghomhdplhhinhhugidqthgvghhrrgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdptghlrghuughiuhdrsggviihnvggrsehmihgtrhhotghhihhprdgtohhmpdhmrgiisehkvghrnhgvlhdrohhrghdprghfrggvrhgsvghrsehsuhhsvgdruggvpdhmrghniheskhgvrhhnvghlrdhorhhgpdhprghlmhgvrhesuggrsggsvghlthdrtghomhdpphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdifvghnshestghsihgvrdhorhhgpdhjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdpthhglhigsehlihhnuhhtrhhonhhigidruggvpdfovfetjfhoshhtpehmohehvdekpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series attempts to fix refcounting issues related to of_irq_parse_one()
and of_irq_parse_raw().

The first issue is simply that most callers of of_irq_parse_one() and
of_irq_parse_raw() don't call of_node_put() on the returned device node when
they no longer need it.

The second issue is a double get() happening in of_irq_parse_one() when
parsing the "interrupts-extended" properties.

WARNING: I tried to be careful when modifying the callers of
of_irq_parse_one()/of_irq_parse_raw() but haven't test-build all the changes.


Jean-Jacques Hiblot (3):
  of: irq: make callers of of_irq_parse_raw() release the device node
  of: irq: make callers of of_irq_parse_one() release the device node
  of: irq: release the node after looking up for "interrupts-extended"

 .../mach-shmobile/regulator-quirk-rcar-gen2.c |  1 +
 arch/powerpc/platforms/fsl_uli1575.c          |  1 +
 arch/powerpc/sysdev/mpic_msi.c                |  1 +
 drivers/bcma/main.c                           |  5 +++-
 drivers/clocksource/timer-clint.c             |  1 +
 drivers/irqchip/irq-mchp-eic.c                |  1 +
 drivers/irqchip/irq-owl-sirq.c                |  1 +
 drivers/irqchip/irq-renesas-rzg2l.c           |  1 +
 drivers/irqchip/irq-sifive-plic.c             |  1 +
 drivers/irqchip/irq-sun6i-r.c                 |  2 ++
 drivers/of/irq.c                              | 30 ++++++++++++++-----
 drivers/of/unittest.c                         |  7 +++++
 drivers/pci/of.c                              |  6 +++-
 drivers/soc/ti/knav_qmss_queue.c              |  3 ++
 drivers/usb/host/xhci-tegra.c                 |  1 +
 15 files changed, 53 insertions(+), 9 deletions(-)

-- 
2.25.1

