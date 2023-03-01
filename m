Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9853B6A777C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Mar 2023 00:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCAXD2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Mar 2023 18:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjCAXDX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Mar 2023 18:03:23 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9DEC50;
        Wed,  1 Mar 2023 15:03:15 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.156.120])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 5F9F121955;
        Wed,  1 Mar 2023 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 1 Mar
 2023 19:52:58 +0100
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
Subject: [PATCH 1/3] of: irq: make callers of of_irq_parse_raw() release the device node
Date:   Wed, 1 Mar 2023 19:52:07 +0100
Message-ID: <20230301185209.274134-2-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301185209.274134-1-jjhiblot@traphandler.com>
References: <20230301185209.274134-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG3EX2.emp2.local (172.16.2.22) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 11460535152125229436
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudelhedguddutdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgtghisehtkeertdertddtnecuhfhrohhmpeflvggrnhdqlfgrtghquhgvshcujfhisghlohhtuceojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqeenucggtffrrghtthgvrhhnpeduteevleevvefggfdvueffffejhfehheeuiedtgedtjeeghfehueduudegfeefueenucfkphepuddvjedrtddrtddruddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshgrrhgrvhgrnhgrkhesghhoohhglhgvrdgtohhmpdhnmhesthhirdgtohhmpdhsshgrnhhtohhshheskhgvrhhnvghlrdhorhhgpdhmrghthhhirghsrdhnhihmrghnsehinhhtvghlrdgtohhmpdhgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdpthhhihgvrhhrhidrrhgvughinhhgsehgmhgrihhlrdgtohhmpdhjohhnrghthhgrnhhhsehnvhhiughirgdrtghomhdplhhinhhugi
 dqrhgvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggsshdrohhrghdplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdgrtghtihhonhhssehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhlihhnuhigqdhsuhhngihisehlihhsthhsrdhlihhnuhigrdguvghvpdguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpsghhvghlghgrrghssehgohhoghhlvgdrtghomhdpfhhrohifrghnugdrlhhishhtsehgmhgrihhlrdgtohhmpdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpshgrmhhuvghlsehshhholhhlrghnugdrohhrghdptghlvghmvghnthdrlhgvghgvrhessghoohhtlhhinhdrtghomhdpghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdpmhgrghhnuhhsrdgurghmmhesghhmrghilhdrtghomhdplhhinhhugiesrghrmhhlihhnuhigrdh
 orhhgrdhukhdpmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhnphhighhgihhnsehgmhgrihhlrdgtohhmpdgthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdiirghjvggtheesghhmrghilhdrtghomhdplhhinhhugidqthgvghhrrgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdptghlrghuughiuhdrsggviihnvggrsehmihgtrhhotghhihhprdgtohhmpdhmrgiisehkvghrnhgvlhdrohhrghdprghfrggvrhgsvghrsehsuhhsvgdruggvpdhmrghniheskhgvrhhnvghlrdhorhhgpdhprghlmhgvrhesuggrsggsvghlthdrtghomhdpphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdifvghnshestghsihgvrdhorhhgpdhjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdpthhglhigsehlihhnuhhtrhhonhhigidruggvpdfovfetjfhoshhtpehmohehvdekpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

of_irq_parse_raw() does a get() on the device node returned in out_irq->np.
Callers of of_irq_parse_raw() must do a put() when they are done with it.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/powerpc/platforms/fsl_uli1575.c | 1 +
 drivers/bcma/main.c                  | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/fsl_uli1575.c b/arch/powerpc/platforms/fsl_uli1575.c
index 84afae7a25617..ba104f6474bc8 100644
--- a/arch/powerpc/platforms/fsl_uli1575.c
+++ b/arch/powerpc/platforms/fsl_uli1575.c
@@ -334,6 +334,7 @@ static void hpcd_final_uli5288(struct pci_dev *dev)
 	laddr[1] = laddr[2] = 0;
 	of_irq_parse_raw(laddr, &oirq);
 	dev->irq = irq_create_of_mapping(&oirq);
+	of_node_put(oirq.np);
 }
 
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, hpcd_quirk_uli1575);
diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 0a8469e0b13ad..11219dd79d327 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -193,7 +193,10 @@ static unsigned int bcma_of_get_irq(struct device *parent,
 		return 0;
 	}
 
-	return irq_create_of_mapping(&out_irq);
+	ret = irq_create_of_mapping(&out_irq);
+	of_node_put(out_irq.np);
+
+	return ret;
 }
 
 static void bcma_of_fill_device(struct device *parent,
-- 
2.25.1

