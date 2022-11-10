Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12F4624AFE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKJTxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 14:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiKJTxc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 14:53:32 -0500
Received: from resqmta-h1p-028593.sys.comcast.net (resqmta-h1p-028593.sys.comcast.net [IPv6:2001:558:fd02:2446::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583B548752
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 11:53:19 -0800 (PST)
Received: from resomta-h1p-027912.sys.comcast.net ([96.102.179.201])
        by resqmta-h1p-028593.sys.comcast.net with ESMTP
        id tC1fouOrcAj3ltDZYogyp9; Thu, 10 Nov 2022 19:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1668109848;
        bh=uZ0DssvlJMaoYvlaYu/eog/eR5+SHYKYU+32z9Q9ZIw=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version:
         Xfinity-Spam-Result;
        b=PT9AMIyO//Us2zznBwAkRFZmqnBpwM7r/fJVUPDr09cbr2RuT5W76cRToqYxdZTia
         p8hrX1iCoHzLn/XZqJoG3XQ5yNb6qSXF8zQsDE8ebmrE4uZBw+2gjOdmCEujRPwfee
         gV+sNurSQexmqbUg5InLvPA/KYLE0W8zblYl40uY5jSg8YpXjQxMlErf/icFBuuOlg
         Ni+Zt8LOjDu3EBOGdJVshYFwquv0AFlgH+wuJ2DdzjQ7JMZh9kPw0iJPM/73mC6llG
         tAh74e+PmV3+cDI99gmy2XFl0fRe17yvJNCqvS/2vkuZlNGP1WvNiRzSGUUJDaLkW3
         2AgfX9Y6RaFkg==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-027912.sys.comcast.net with ESMTPA
        id tDZ4oZTHiVTvltDZFokli2; Thu, 10 Nov 2022 19:50:30 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeggddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedtteeljeffgfffveehhfetveefuedvheevffffhedtjeeuvdevgfeftddtheeftdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehvihguhigrshesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgrnhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhrvghniihordhpihgvrhgrlhhishhisegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
 hugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdruggvpdhrtghpthhtohepphgrlhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2 3/7] PCI: pciehp: Expose the poll loop to other drivers
Date:   Thu, 10 Nov 2022 12:50:11 -0700
Message-Id: <20221110195015.207-4-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110195015.207-1-jonathan.derrick@linux.dev>
References: <20221110195015.207-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Abstract the poll loop into an 'events pending' check and a 'handle
events' method in order to allow another driver to call the polling
loop.

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 drivers/pci/hotplug/pciehp.h     |  2 ++
 drivers/pci/hotplug/pciehp_hpc.c | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index e0a614acee05..e221f5d12ad5 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -157,6 +157,8 @@ struct controller {
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
 
+bool pciehp_events_pending(struct controller *ctrl);
+void pciehp_handle_events(struct controller *ctrl);
 void pciehp_request(struct controller *ctrl, int action);
 void pciehp_handle_button_press(struct controller *ctrl);
 void pciehp_handle_disable_request(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 040ae076ec0e..f711448e0a70 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -764,6 +764,17 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	return ret;
 }
 
+bool pciehp_events_pending(struct controller *ctrl)
+{
+	return pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD ||
+	       atomic_read(&ctrl->pending_events);
+}
+
+void pciehp_handle_events(struct controller *ctrl)
+{
+	pciehp_ist(IRQ_NOTCONNECTED, ctrl);
+}
+
 static int pciehp_poll(void *data)
 {
 	struct controller *ctrl = data;
@@ -772,9 +783,8 @@ static int pciehp_poll(void *data)
 
 	while (!kthread_should_stop()) {
 		/* poll for interrupt events or user requests */
-		while (pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD ||
-		       atomic_read(&ctrl->pending_events))
-			pciehp_ist(IRQ_NOTCONNECTED, ctrl);
+		while (pciehp_events_pending(ctrl))
+			pciehp_handle_events(ctrl);
 
 		if (pciehp_poll_time <= 0 || pciehp_poll_time > 60)
 			pciehp_poll_time = 2; /* clamp to sane value */
-- 
2.30.2

