Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD463D6CED
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 05:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhG0C44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 22:56:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:45177 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235202AbhG0C4z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Jul 2021 22:56:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="191955846"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="191955846"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 20:37:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="474230317"
Received: from nmanikan-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.209.99.32])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 20:37:21 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     intel-wired-lan@lists.osuosl.org
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        sasha.neftin@intel.com, anthony.l.nguyen@intel.com,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        netdev@vger.kernel.org, mlichvar@redhat.com,
        richardcochran@gmail.com, hch@infradead.org, helgaas@kernel.org,
        pmenzel@molgen.mpg.de
Subject: [PATCH next-queue v6 4/4] igc: Add support for PTP getcrosststamp()
Date:   Mon, 26 Jul 2021 20:36:57 -0700
Message-Id: <20210727033657.39885-5-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210727033657.39885-1-vinicius.gomes@intel.com>
References: <20210727033657.39885-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

i225 supports PCIe Precision Time Measurement (PTM), allowing us to
support the PTP_SYS_OFFSET_PRECISE ioctl() in the driver via the
getcrosststamp() function.

The easiest way to expose the PTM registers would be to configure the PTM
dialogs to run periodically, but the PTP_SYS_OFFSET_PRECISE ioctl()
semantics are more aligned to using a kind of "one-shot" way of retrieving
the PTM timestamps. But this causes a bit more code to be written: the
trigger registers for the PTM dialogs are not cleared automatically.

i225 can be configured to send "fake" packets with the PTM
information, adding support for handling these types of packets is
left for the future.

PTM improves the accuracy of time synchronization, for example, using
phc2sys, while a simple application is sending packets as fast as
possible. First, without .getcrosststamp():

phc2sys[191.382]: enp4s0 sys offset      -959 s2 freq    -454 delay   4492
phc2sys[191.482]: enp4s0 sys offset       798 s2 freq   +1015 delay   4069
phc2sys[191.583]: enp4s0 sys offset       962 s2 freq   +1418 delay   3849
phc2sys[191.683]: enp4s0 sys offset       924 s2 freq   +1669 delay   3753
phc2sys[191.783]: enp4s0 sys offset       664 s2 freq   +1686 delay   3349
phc2sys[191.883]: enp4s0 sys offset       218 s2 freq   +1439 delay   2585
phc2sys[191.983]: enp4s0 sys offset       761 s2 freq   +2048 delay   3750
phc2sys[192.083]: enp4s0 sys offset       756 s2 freq   +2271 delay   4061
phc2sys[192.183]: enp4s0 sys offset       809 s2 freq   +2551 delay   4384
phc2sys[192.283]: enp4s0 sys offset      -108 s2 freq   +1877 delay   2480
phc2sys[192.383]: enp4s0 sys offset     -1145 s2 freq    +807 delay   4438
phc2sys[192.484]: enp4s0 sys offset       571 s2 freq   +2180 delay   3849
phc2sys[192.584]: enp4s0 sys offset       241 s2 freq   +2021 delay   3389
phc2sys[192.684]: enp4s0 sys offset       405 s2 freq   +2257 delay   3829
phc2sys[192.784]: enp4s0 sys offset        17 s2 freq   +1991 delay   3273
phc2sys[192.884]: enp4s0 sys offset       152 s2 freq   +2131 delay   3948
phc2sys[192.984]: enp4s0 sys offset      -187 s2 freq   +1837 delay   3162
phc2sys[193.084]: enp4s0 sys offset     -1595 s2 freq    +373 delay   4557
phc2sys[193.184]: enp4s0 sys offset       107 s2 freq   +1597 delay   3740
phc2sys[193.284]: enp4s0 sys offset       199 s2 freq   +1721 delay   4010
phc2sys[193.385]: enp4s0 sys offset      -169 s2 freq   +1413 delay   3701
phc2sys[193.485]: enp4s0 sys offset       -47 s2 freq   +1484 delay   3581
phc2sys[193.585]: enp4s0 sys offset       -65 s2 freq   +1452 delay   3778
phc2sys[193.685]: enp4s0 sys offset        95 s2 freq   +1592 delay   3888
phc2sys[193.785]: enp4s0 sys offset       206 s2 freq   +1732 delay   4445
phc2sys[193.885]: enp4s0 sys offset      -652 s2 freq    +936 delay   2521
phc2sys[193.985]: enp4s0 sys offset      -203 s2 freq   +1189 delay   3391
phc2sys[194.085]: enp4s0 sys offset      -376 s2 freq    +955 delay   2951
phc2sys[194.185]: enp4s0 sys offset      -134 s2 freq   +1084 delay   3330
phc2sys[194.285]: enp4s0 sys offset       -22 s2 freq   +1156 delay   3479
phc2sys[194.386]: enp4s0 sys offset        32 s2 freq   +1204 delay   3602
phc2sys[194.486]: enp4s0 sys offset       122 s2 freq   +1303 delay   3731

Statistics for this run (total of 2179 lines), in nanoseconds:
  average: -1.12
  stdev: 634.80
  max: 1551
  min: -2215

With .getcrosststamp() via PCIe PTM:

phc2sys[367.859]: enp4s0 sys offset         6 s2 freq   +1727 delay      0
phc2sys[367.959]: enp4s0 sys offset        -2 s2 freq   +1721 delay      0
phc2sys[368.059]: enp4s0 sys offset         5 s2 freq   +1727 delay      0
phc2sys[368.160]: enp4s0 sys offset        -1 s2 freq   +1723 delay      0
phc2sys[368.260]: enp4s0 sys offset        -4 s2 freq   +1719 delay      0
phc2sys[368.360]: enp4s0 sys offset        -5 s2 freq   +1717 delay      0
phc2sys[368.460]: enp4s0 sys offset         1 s2 freq   +1722 delay      0
phc2sys[368.560]: enp4s0 sys offset        -3 s2 freq   +1718 delay      0
phc2sys[368.660]: enp4s0 sys offset         5 s2 freq   +1725 delay      0
phc2sys[368.760]: enp4s0 sys offset        -1 s2 freq   +1721 delay      0
phc2sys[368.860]: enp4s0 sys offset         0 s2 freq   +1721 delay      0
phc2sys[368.960]: enp4s0 sys offset         0 s2 freq   +1721 delay      0
phc2sys[369.061]: enp4s0 sys offset         4 s2 freq   +1725 delay      0
phc2sys[369.161]: enp4s0 sys offset         1 s2 freq   +1724 delay      0
phc2sys[369.261]: enp4s0 sys offset         4 s2 freq   +1727 delay      0
phc2sys[369.361]: enp4s0 sys offset         8 s2 freq   +1732 delay      0
phc2sys[369.461]: enp4s0 sys offset         7 s2 freq   +1733 delay      0
phc2sys[369.561]: enp4s0 sys offset         4 s2 freq   +1733 delay      0
phc2sys[369.661]: enp4s0 sys offset         1 s2 freq   +1731 delay      0
phc2sys[369.761]: enp4s0 sys offset         1 s2 freq   +1731 delay      0
phc2sys[369.861]: enp4s0 sys offset        -5 s2 freq   +1725 delay      0
phc2sys[369.961]: enp4s0 sys offset        -4 s2 freq   +1725 delay      0
phc2sys[370.062]: enp4s0 sys offset         2 s2 freq   +1730 delay      0
phc2sys[370.162]: enp4s0 sys offset        -7 s2 freq   +1721 delay      0
phc2sys[370.262]: enp4s0 sys offset        -3 s2 freq   +1723 delay      0
phc2sys[370.362]: enp4s0 sys offset         1 s2 freq   +1726 delay      0
phc2sys[370.462]: enp4s0 sys offset        -3 s2 freq   +1723 delay      0
phc2sys[370.562]: enp4s0 sys offset        -1 s2 freq   +1724 delay      0
phc2sys[370.662]: enp4s0 sys offset        -4 s2 freq   +1720 delay      0
phc2sys[370.762]: enp4s0 sys offset        -7 s2 freq   +1716 delay      0
phc2sys[370.862]: enp4s0 sys offset        -2 s2 freq   +1719 delay      0

Statistics for this run (total of 2179 lines), in nanoseconds:
  average: 0.14
  stdev: 5.03
  max: 48
  min: -27

For reference, the statistics for runs without PCIe congestion show
that the improvements from enabling PTM are less dramatic. For two
runs of 16466 entries:
  without PTM: avg -0.04 stdev 10.57 max 39 min -42
  with PTM: avg 0.01 stdev 4.20 max 19 min -16

One possible explanation is that when PTM is not enabled, and there's a lot
of traffic in the PCIe fabric, some register reads will take more time
than the others because of congestion on the PCIe fabric.

When PTM is enabled, even if the PTM dialogs take more time to
complete under heavy traffic, the time measurements do not depend on
the time to read the registers.

This was implemented following the i225 EAS version 0.993.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |   1 +
 drivers/net/ethernet/intel/igc/igc_defines.h |  31 ++++
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 179 +++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_regs.h    |  23 +++
 4 files changed, 234 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index a0ecfe5a4078..2d17a6da63cf 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -227,6 +227,7 @@ struct igc_adapter {
 	struct timecounter tc;
 	struct timespec64 prev_ptp_time; /* Pre-reset PTP clock */
 	ktime_t ptp_reset_start; /* Reset time in clock mono */
+	struct system_time_snapshot snapshot;
 
 	char fw_version[32];
 
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 136108687f35..33e5d89d17a3 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -523,6 +523,37 @@
 #define IGC_RXCSUM_CRCOFL	0x00000800   /* CRC32 offload enable */
 #define IGC_RXCSUM_PCSD		0x00002000   /* packet checksum disabled */
 
+/* PCIe PTM Control */
+#define IGC_PTM_CTRL_START_NOW	BIT(29) /* Start PTM Now */
+#define IGC_PTM_CTRL_EN		BIT(30) /* Enable PTM */
+#define IGC_PTM_CTRL_TRIG	BIT(31) /* PTM Cycle trigger */
+#define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x2f) << 2)
+#define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
+
+#define IGC_PTM_SHORT_CYC_DEFAULT	10  /* Default Short/interrupted cycle interval */
+#define IGC_PTM_CYC_TIME_DEFAULT	5   /* Default PTM cycle time */
+#define IGC_PTM_TIMEOUT_DEFAULT		255 /* Default timeout for PTM errors */
+
+/* PCIe Digital Delay */
+#define IGC_PCIE_DIG_DELAY_DEFAULT	0x01440000
+
+/* PCIe PHY Delay */
+#define IGC_PCIE_PHY_DELAY_DEFAULT	0x40900000
+
+#define IGC_TIMADJ_ADJUST_METH		0x40000000
+
+/* PCIe PTM Status */
+#define IGC_PTM_STAT_VALID		BIT(0) /* PTM Status */
+#define IGC_PTM_STAT_RET_ERR		BIT(1) /* Root port timeout */
+#define IGC_PTM_STAT_BAD_PTM_RES	BIT(2) /* PTM Response msg instead of PTM Response Data */
+#define IGC_PTM_STAT_T4M1_OVFL		BIT(3) /* T4 minus T1 overflow */
+#define IGC_PTM_STAT_ADJUST_1ST		BIT(4) /* 1588 timer adjusted during 1st PTM cycle */
+#define IGC_PTM_STAT_ADJUST_CYC		BIT(5) /* 1588 timer adjusted during non-1st PTM cycle */
+
+/* PCIe PTM Cycle Control */
+#define IGC_PTM_CYCLE_CTRL_CYC_TIME(msec)	((msec) & 0x3ff) /* PTM Cycle Time (msec) */
+#define IGC_PTM_CYCLE_CTRL_AUTO_CYC_EN		BIT(31) /* PTM Cycle Control */
+
 /* GPY211 - I225 defines */
 #define GPY_MMD_MASK		0xFFFF0000
 #define GPY_MMD_SHIFT		16
diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 4ae19c6a3247..ca1b728f1d97 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -9,6 +9,8 @@
 #include <linux/ptp_classify.h>
 #include <linux/clocksource.h>
 #include <linux/ktime.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
 
 #define INCVALUE_MASK		0x7fffffff
 #define ISGN			0x80000000
@@ -16,6 +18,9 @@
 #define IGC_SYSTIM_OVERFLOW_PERIOD	(HZ * 60 * 9)
 #define IGC_PTP_TX_TIMEOUT		(HZ * 15)
 
+#define IGC_PTM_STAT_SLEEP		2
+#define IGC_PTM_STAT_TIMEOUT		100
+
 /* SYSTIM read access for I225 */
 void igc_ptp_read(struct igc_adapter *adapter, struct timespec64 *ts)
 {
@@ -752,6 +757,147 @@ int igc_ptp_get_ts_config(struct net_device *netdev, struct ifreq *ifr)
 		-EFAULT : 0;
 }
 
+/* The two conditions below must be met for cross timestamping via
+ * PCIe PTM:
+ *
+ * 1. We have an way to convert the timestamps in the PTM messages
+ *    to something related to the system clocks (right now, only
+ *    X86 systems with support for the Always Running Timer allow that);
+ *
+ * 2. We have PTM enabled in the path from the device to the PCIe root port.
+ */
+static bool igc_is_crosststamp_supported(struct igc_adapter *adapter)
+{
+	return IS_ENABLED(CONFIG_X86_TSC) ? pcie_ptm_enabled(adapter->pdev) : false;
+}
+
+static struct system_counterval_t igc_device_tstamp_to_system(u64 tstamp)
+{
+#if IS_ENABLED(CONFIG_X86_TSC)
+	return convert_art_ns_to_tsc(tstamp);
+#else
+	return (struct system_counterval_t) { };
+#endif
+}
+
+static void igc_ptm_log_error(struct igc_adapter *adapter, u32 ptm_stat)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	switch (ptm_stat) {
+	case IGC_PTM_STAT_RET_ERR:
+		netdev_err(netdev, "PTM Error: Root port timeout\n");
+		break;
+	case IGC_PTM_STAT_BAD_PTM_RES:
+		netdev_err(netdev, "PTM Error: Bad response, PTM Response Data expected\n");
+		break;
+	case IGC_PTM_STAT_T4M1_OVFL:
+		netdev_err(netdev, "PTM Error: T4 minus T1 overflow\n");
+		break;
+	case IGC_PTM_STAT_ADJUST_1ST:
+		netdev_err(netdev, "PTM Error: 1588 timer adjusted during first PTM cycle\n");
+		break;
+	case IGC_PTM_STAT_ADJUST_CYC:
+		netdev_err(netdev, "PTM Error: 1588 timer adjusted during non-first PTM cycle\n");
+		break;
+	default:
+		netdev_err(netdev, "PTM Error: Unknown error (%#x)\n", ptm_stat);
+		break;
+	}
+}
+
+static int igc_phc_get_syncdevicetime(ktime_t *device,
+				      struct system_counterval_t *system,
+				      void *ctx)
+{
+	struct igc_adapter *adapter = ctx;
+	struct igc_hw *hw = &adapter->hw;
+	u32 stat, t2_curr_h, t2_curr_l, ctrl;
+	int err, count = 100;
+	ktime_t t1, t2_curr;
+
+	/* Get a snapshot of system clocks to use as historic value. */
+	ktime_get_snapshot(&adapter->snapshot);
+
+	do {
+		/* Doing this in a loop because in the event of a
+		 * badly timed (ha!) system clock adjustment, we may
+		 * get PTM errors from the PCI root, but these errors
+		 * are transitory. Repeating the process returns valid
+		 * data eventually.
+		 */
+
+		/* To "manually" start the PTM cycle we need to clear and
+		 * then set again the TRIG bit.
+		 */
+		ctrl = rd32(IGC_PTM_CTRL);
+		ctrl &= ~IGC_PTM_CTRL_TRIG;
+		wr32(IGC_PTM_CTRL, ctrl);
+		ctrl |= IGC_PTM_CTRL_TRIG;
+		wr32(IGC_PTM_CTRL, ctrl);
+
+		/* The cycle only starts "for real" when software notifies
+		 * that it has read the registers, this is done by setting
+		 * VALID bit.
+		 */
+		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
+
+		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
+					 stat, IGC_PTM_STAT_SLEEP,
+					 IGC_PTM_STAT_TIMEOUT);
+		if (err < 0) {
+			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
+			return err;
+		}
+
+		if ((stat & IGC_PTM_STAT_VALID) == IGC_PTM_STAT_VALID)
+			break;
+
+		if (stat & ~IGC_PTM_STAT_VALID) {
+			/* An error occurred, log it. */
+			igc_ptm_log_error(adapter, stat);
+			/* The STAT register is write-1-to-clear (W1C),
+			 * so write the previous error status to clear it.
+			 */
+			wr32(IGC_PTM_STAT, stat);
+			continue;
+		}
+	} while (--count);
+
+	if (!count) {
+		netdev_err(adapter->netdev, "Exceeded number of tries for PTM cycle\n");
+		return -ETIMEDOUT;
+	}
+
+	t1 = ktime_set(rd32(IGC_PTM_T1_TIM0_H), rd32(IGC_PTM_T1_TIM0_L));
+
+	t2_curr_l = rd32(IGC_PTM_CURR_T2_L);
+	t2_curr_h = rd32(IGC_PTM_CURR_T2_H);
+
+	/* FIXME: When the register that tells the endianness of the
+	 * PTM registers are implemented, check them here and add the
+	 * appropriate conversion.
+	 */
+	t2_curr_h = swab32(t2_curr_h);
+
+	t2_curr = ((s64)t2_curr_h << 32 | t2_curr_l);
+
+	*device = t1;
+	*system = igc_device_tstamp_to_system(t2_curr);
+
+	return 0;
+}
+
+static int igc_ptp_getcrosststamp(struct ptp_clock_info *ptp,
+				  struct system_device_crosststamp *cts)
+{
+	struct igc_adapter *adapter = container_of(ptp, struct igc_adapter,
+						   ptp_caps);
+
+	return get_device_system_crosststamp(igc_phc_get_syncdevicetime,
+					     adapter, &adapter->snapshot, cts);
+}
+
 /**
  * igc_ptp_init - Initialize PTP functionality
  * @adapter: Board private structure
@@ -788,6 +934,11 @@ void igc_ptp_init(struct igc_adapter *adapter)
 		adapter->ptp_caps.n_per_out = IGC_N_PEROUT;
 		adapter->ptp_caps.n_pins = IGC_N_SDP;
 		adapter->ptp_caps.verify = igc_ptp_verify_pin;
+
+		if (!igc_is_crosststamp_supported(adapter))
+			break;
+
+		adapter->ptp_caps.getcrosststamp = igc_ptp_getcrosststamp;
 		break;
 	default:
 		adapter->ptp_clock = NULL;
@@ -879,7 +1030,9 @@ void igc_ptp_stop(struct igc_adapter *adapter)
 void igc_ptp_reset(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
+	u32 cycle_ctrl, ctrl;
 	unsigned long flags;
+	u32 timadj;
 
 	/* reset the tstamp_config */
 	igc_ptp_set_timestamp_mode(adapter, &adapter->tstamp_config);
@@ -888,12 +1041,38 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 
 	switch (adapter->hw.mac.type) {
 	case igc_i225:
+		timadj = rd32(IGC_TIMADJ);
+		timadj |= IGC_TIMADJ_ADJUST_METH;
+		wr32(IGC_TIMADJ, timadj);
+
 		wr32(IGC_TSAUXC, 0x0);
 		wr32(IGC_TSSDP, 0x0);
 		wr32(IGC_TSIM,
 		     IGC_TSICR_INTERRUPTS |
 		     (adapter->pps_sys_wrap_on ? IGC_TSICR_SYS_WRAP : 0));
 		wr32(IGC_IMS, IGC_IMS_TS);
+
+		if (!igc_is_crosststamp_supported(adapter))
+			break;
+
+		wr32(IGC_PCIE_DIG_DELAY, IGC_PCIE_DIG_DELAY_DEFAULT);
+		wr32(IGC_PCIE_PHY_DELAY, IGC_PCIE_PHY_DELAY_DEFAULT);
+
+		cycle_ctrl = IGC_PTM_CYCLE_CTRL_CYC_TIME(IGC_PTM_CYC_TIME_DEFAULT);
+
+		wr32(IGC_PTM_CYCLE_CTRL, cycle_ctrl);
+
+		ctrl = IGC_PTM_CTRL_EN |
+			IGC_PTM_CTRL_START_NOW |
+			IGC_PTM_CTRL_SHRT_CYC(IGC_PTM_SHORT_CYC_DEFAULT) |
+			IGC_PTM_CTRL_PTM_TO(IGC_PTM_TIMEOUT_DEFAULT) |
+			IGC_PTM_CTRL_TRIG;
+
+		wr32(IGC_PTM_CTRL, ctrl);
+
+		/* Force the first cycle to run. */
+		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
+
 		break;
 	default:
 		/* No work to do. */
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 828c3501c448..dbba2eb2a247 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -245,6 +245,29 @@
 #define IGC_TXSTMPL	0x0B618  /* Tx timestamp value Low - RO */
 #define IGC_TXSTMPH	0x0B61C  /* Tx timestamp value High - RO */
 
+#define IGC_TIMADJ	0x0B60C  /* Time Adjustment Offset Register */
+
+/* PCIe Registers */
+#define IGC_PTM_CTRL		0x12540  /* PTM Control */
+#define IGC_PTM_STAT		0x12544  /* PTM Status */
+#define IGC_PTM_CYCLE_CTRL	0x1254C  /* PTM Cycle Control */
+
+/* PTM Time registers */
+#define IGC_PTM_T1_TIM0_L	0x12558  /* T1 on Timer 0 Low */
+#define IGC_PTM_T1_TIM0_H	0x1255C  /* T1 on Timer 0 High */
+
+#define IGC_PTM_CURR_T2_L	0x1258C  /* Current T2 Low */
+#define IGC_PTM_CURR_T2_H	0x12590  /* Current T2 High */
+#define IGC_PTM_PREV_T2_L	0x12584  /* Previous T2 Low */
+#define IGC_PTM_PREV_T2_H	0x12588  /* Previous T2 High */
+#define IGC_PTM_PREV_T4M1	0x12578  /* T4 Minus T1 on previous PTM Cycle */
+#define IGC_PTM_CURR_T4M1	0x1257C  /* T4 Minus T1 on this PTM Cycle */
+#define IGC_PTM_PREV_T3M2	0x12580  /* T3 Minus T2 on previous PTM Cycle */
+#define IGC_PTM_TDELAY		0x12594  /* PTM PCIe Link Delay */
+
+#define IGC_PCIE_DIG_DELAY	0x12550  /* PCIe Digital Delay */
+#define IGC_PCIE_PHY_DELAY	0x12554  /* PCIe PHY Delay */
+
 /* Management registers */
 #define IGC_MANC	0x05820  /* Management Control - RW */
 
-- 
2.32.0

