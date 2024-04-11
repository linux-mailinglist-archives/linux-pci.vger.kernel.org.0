Return-Path: <linux-pci+bounces-6131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17948A1986
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 18:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2331F240B1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 16:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC79515F41E;
	Thu, 11 Apr 2024 15:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="RUXgOgNR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242215E5BE;
	Thu, 11 Apr 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849742; cv=none; b=KBHBVpsoFcgHkx1G2sB53fXa2sMJm6M4ene+P1g4LphC0XT3l7hZspZVUSvlu1EI8iTVvpXUV4Zmkijmd2m009TccKhbSkBO/afcXbKQL3LfoVw+pYF//sGCKjenLuWM1oWFH2j84U+XvwxcfWvNJ6jCJBvv+S4di7l2Y7QzZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849742; c=relaxed/simple;
	bh=t7LCTP5JLqZApRRg7PJZoueTPiryqUqxTxseU/Gaw78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9vI8v8q5NqBq65WC9VoM3RounSsIdvJnU+j1Sb5+Pag9S35MJTJhIH4ksXPrm+sdJXGhApCQa9+TriQt8yE+M3EPRZrRd3jMWKFyjZrOBJzSdXlzKibZvsIASUu0AlKdNjwoUxFXlWZzGqsFa39PxGT4PpNKh2+5dAQLfSSpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=RUXgOgNR; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712849733; x=1713454533; i=parker@finest.io;
	bh=DEoExHw1dSCdiZdVXHWX8CWM4eQBARS0KolNHJ5hl54=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=RUXgOgNRzU6eLszitAUlvXKgOKuabWyG6/qMZek+4mf9ltr61zxvpka4X4Imbj0B
	 Z0hImXNf6y2sGoCvAe1dFnOU9I5OZhPGq0pATW9faIjxhlRhW3tdwJoZyD2bS+Wjt
	 EMijUBDppt+jSKJIQoZs3tbHaMCQlaqr/JRtH/1bW9xA3DhVNfMDOR5RRkxlei+Gd
	 aHxuHs1cx2prFKbeiRb+Ju35cA1Mmef4aPSiBuLwfKELZf3UYBWxdZ/ZijJVtF1oZ
	 CaZZYpuVt7bDAcPNbjbq+/rRnoR85BwU6MWoNqecgwqpwic5v7RO04d1fUFujHTeK
	 qoYvLALNmyy4O5w7dQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from finest.io ([98.159.241.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LfkxY-1sX5Sp0EhO-00htud; Thu, 11 Apr
 2024 17:30:05 +0200
From: parker@finest.io
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>
Subject: [PATCH 2/2] serial: exar: adding CTI PCI/PCIe serial port support to 8250_exar
Date: Thu, 11 Apr 2024 11:29:27 -0400
Message-ID: <9ffdef053f455c87f705dff169346bc10d307787.1712846026.git.pnewman@connecttech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1712846025.git.pnewman@connecttech.com>
References: <cover.1712846025.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rgO1F1bAKiy2Rlht0ZqQo+ySh7cTBCrUmCGrilPsCewW+RmFMEx
 HlvaYNTthwFNbS3+3mClIDAH/iBAbEzvX1OdxackOVeD5OP73bcwZlRLBDqBOqWkKSua2jP
 CGLbh/yMIec4zj5hQwp2cswIpVwL7RjjnZLjuEbDxRbGVkGCchJbNeKKrvxOJGCIKBHmiRC
 jhgV0J10tuxKGfStITr2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W3CyV7pNnXY=;t8asrVlvEOQJFhBbeT7nuSZ6Qff
 pGnuKUodNHIJ0yJ9KWPo5SDVyyH5bI/owFVij2nXsKdtZibkBjJCNaL0Zki0JDqibuEYA/0PD
 1kopTovsVROqkug+stlqTY8tLLIUPqTINroZUhViIlsIsHtt5REGSiNHEHpT/+qeAhaCZ5Svx
 7CTdZarbRJHO09daLVL1sIV3MHdVom/KlOTvCLBS6UbD/7r2f+EXYoaEreXYVhRzPUDEymMXx
 IbAnH9dh6wHTkFHQ0KP0n4DmteMI4fH47gic7jrymNA2KyWN5zr3qu+fJ6BJIoWE1bLKpmTnB
 sEqdlcmiSJRDXEZS/vt8+hjhAwPLED/P0xGPITXYzirmFLdRTExc1k6rEFB6ZjWBuJM4KpGYn
 iwn24O/EJiqHSqj6rX+gca5LQqAoQ6xG2tG5lS/P0IGjui4ARDxy6zkRjho1WCfs0RdYZsAIc
 tXGn1jNyWuPO5bV1wWchbH3XjRpk5wchwfHBQkxp3m+TOhwrHjLOo9UZ03DF+8FkJp42Rgixl
 TiCbiXfclf2hQ+2Rbk7FYY2jmzeObtGdL+KRWeYSPYVyTH/IJ/QWXgOUkid3l7PoNsPQTJFK4
 CssQ3DSuz9s99yBnW4JEKgFtvBiNoz2lwtN7yNfffSja/ImPTe7ew5lWj+lIenq1zkNf0Gg8O
 OkKwfGoOjsJuWx0E7en0vbKVILQz9A0TxpSx/xQ/9bBjtQoPa2QvSGy2FibHeaR29XpXNAE4H
 0AnzjWBz1iWIOrLVsFiHjUmLwwQVFGhS80riiIc8Y9WMp/CFuewE8g=

From: Parker Newman <pnewman@connecttech.com>

This patch adds support for most of Connect Tech's (CTI) PCI/PCIe
serial cards to the 8250_exar driver.

Major changes:
 - Added (optional) board_setup function called once during probe
 - Added exar_get_nr_ports function
 - Removed old Connect Tech setup functions
 - Added new UART family based CTI setup functions
 - Added PCI IDs entries for Exar XR17V25x and CTI FPGA based cards
 - Added MPIO functions for configuring/setting a single MPIO
 - Added support for reading from the Exar EEPROM

Signed-off-by: Parker Newman <pnewman@connecttech.com>
=2D--
 drivers/tty/serial/8250/8250_exar.c | 1089 +++++++++++++++++++++++++--
 1 file changed, 1019 insertions(+), 70 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250=
/8250_exar.c
index eb00fcd79a8e..8516b92741f2 100644
=2D-- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -83,12 +83,25 @@
 #define UART_EXAR_DLD			0x02 /* Divisor Fractional */
 #define UART_EXAR_DLD_485_POLARITY	0x80 /* RS-485 Enable Signal Polarity =
*/

+/* EEPROM registers */
+#define UART_EXAR_REGB                  0x8e
+#define UART_EXAR_REGB_EECK             BIT(4)
+#define UART_EXAR_REGB_EECS             BIT(5)
+#define UART_EXAR_REGB_EEDI             BIT(6)
+#define UART_EXAR_REGB_EEDO             BIT(7)
+#define UART_EXAR_REGB_EE_ADDR_SIZE     6
+#define UART_EXAR_REGB_EE_DATA_SIZE     16
+
+#define UART_EXAR_XR17C15X_PORT_OFFSET  0x200
+#define UART_EXAR_XR17V25X_PORT_OFFSET  0x200
+#define UART_EXAR_XR17V35X_PORT_OFFSET  0x400
+
 /*
  * IOT2040 MPIO wiring semantics:
  *
  * MPIO		Port	Function
  * ----		----	--------
- * 0		2 	Mode bit 0
+ * 0		2	Mode bit 0
  * 1		2	Mode bit 1
  * 2		2	Terminate bus
  * 3		-	<reserved>
@@ -118,36 +131,293 @@
 #define IOT2040_UARTS_ENABLE		0x03
 #define IOT2040_UARTS_GPIO_HI_MODE	0xF8	/* enable & LED as outputs */

+/* CTI EEPROM offsets */
+#define CTI_EE_OFF_XR17C15X_OSC_FREQ	0x04  /* 2 words (4 bytes) */
+#define CTI_EE_OFF_XR17V25X_OSC_FREQ    0x08  /* 2 words (4 bytes) */
+#define CTI_EE_OFF_XR17C15X_PART_NUM    0x0A  /* 4 words (8 bytes) */
+#define CTI_EE_OFF_XR17V25X_PART_NUM    0x0E  /* 4 words (8 bytes) */
+#define CTI_EE_OFF_XR17C15X_SERIAL_NUM  0x0E  /* 1 word  (2 bytes) */
+#define CTI_EE_OFF_XR17V25X_SERIAL_NUM  0x12  /* 1 word  (2 bytes) */
+#define CTI_EE_OFF_XR17V35X_SERIAL_NUM  0x11  /* 2 word  (4 bytes) */
+#define CTI_EE_OFF_XR17V35X_BOARD_FLAGS 0x13  /* 1 word  (2 bytes) */
+#define CTI_EE_OFF_XR17V35X_PORT_FLAGS	0x14  /* 1 word (per port) */
+
+#define CTI_FPGA_RS485_IO_REG		0x2008
+
+#define CTI_DEFAULT_PCI_OSC_FREQ	29491200
+#define CTI_DEFAULT_PCIE_OSC_FREQ	125000000
+#define CTI_DEFAULT_FPGA_OSC_FREQ	33333333
+
+/*
+ * CTI Serial port line types. These match the values stored in the first
+ * nibble of the CTI EEPROM port_flags word.
+ */
+enum cti_port_type {
+	CTI_PORT_TYPE_NONE =3D 0,
+	CTI_PORT_TYPE_RS232,            //RS232 ONLY
+	CTI_PORT_TYPE_RS422_485,        //RS422/RS485 ONLY
+	CTI_PORT_TYPE_RS232_422_485_HW, //RS232/422/485 HW ONLY Switchable
+	CTI_PORT_TYPE_RS232_422_485_SW, //RS232/422/485 SW ONLY Switchable
+	CTI_PORT_TYPE_RS232_422_485_4B, //RS232/422/485 HW/SW (4bit ex. BCG004)
+	CTI_PORT_TYPE_RS232_422_485_2B, //RS232/422/485 HW/SW (2bit ex. BBG008)
+	CTI_PORT_TYPE_MAX,
+};
+
+#define CTI_PORT_TYPE_VALID(_port_type) \
+	(((_port_type) > CTI_PORT_TYPE_NONE) && \
+	((_port_type) < CTI_PORT_TYPE_MAX))
+
+#define CTI_PORT_TYPE_RS485(_port_type) \
+	(((_port_type) > CTI_PORT_TYPE_RS232) && \
+	((_port_type) < CTI_PORT_TYPE_MAX))
+
 struct exar8250;

 struct exar8250_platform {
 	int (*rs485_config)(struct uart_port *port, struct ktermios *termios,
 			    struct serial_rs485 *rs485);
 	const struct serial_rs485 *rs485_supported;
-	int (*register_gpio)(struct pci_dev *, struct uart_8250_port *);
-	void (*unregister_gpio)(struct uart_8250_port *);
+	int (*register_gpio)(struct pci_dev *pcidev, struct uart_8250_port *port=
);
+	void (*unregister_gpio)(struct uart_8250_port *port);
 };

 /**
  * struct exar8250_board - board information
  * @num_ports: number of serial ports
  * @reg_shift: describes UART register mapping in PCI memory
- * @setup: quirk run at ->probe() stage
+ * @board_setup: quirk run once at ->probe() stage before setting up port=
s
+ * @setup: quirk run at ->probe() stage for each port
  * @exit: quirk run at ->remove() stage
  */
 struct exar8250_board {
 	unsigned int num_ports;
 	unsigned int reg_shift;
-	int	(*setup)(struct exar8250 *, struct pci_dev *,
-			 struct uart_8250_port *, int);
+	int     (*board_setup)(struct exar8250 *priv);
+	int	(*setup)(struct exar8250 *priv, struct pci_dev *pcidev,
+			 struct uart_8250_port *port, int idx);
 	void	(*exit)(struct pci_dev *pcidev);
 };

 struct exar8250 {
 	unsigned int		nr;
+	unsigned int            osc_freq;
+	struct pci_dev		*pcidev;
 	struct exar8250_board	*board;
 	void __iomem		*virt;
-	int			line[];
+	int			line[]; //must be last
+};
+
+static inline void exar_write_reg(struct exar8250 *priv,
+				unsigned int reg, uint8_t value)
+{
+	if (!priv || !priv->virt)
+		return;
+
+	writeb(value, priv->virt + reg);
+}
+
+static inline uint8_t exar_read_reg(struct exar8250 *priv, unsigned int r=
eg)
+{
+	if (!priv || !priv->virt)
+		return 0;
+
+	return readb(priv->virt + reg);
+}
+
+static inline void exar_ee_select(struct exar8250 *priv, bool enable)
+{
+	uint8_t value =3D 0x00;
+
+	if (enable)
+		value |=3D UART_EXAR_REGB_EECS;
+
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	udelay(2);
+}
+
+static inline void exar_ee_write_bit(struct exar8250 *priv, int bit)
+{
+	uint8_t value =3D UART_EXAR_REGB_EECS;
+
+	if (bit)
+		value |=3D UART_EXAR_REGB_EEDI;
+
+	//Clock out the bit on the i2c interface
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	udelay(2);
+
+	value |=3D UART_EXAR_REGB_EECK;
+
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	udelay(2);
+}
+
+static inline uint8_t exar_ee_read_bit(struct exar8250 *priv)
+{
+	uint8_t regb;
+	uint8_t value =3D UART_EXAR_REGB_EECS;
+
+	//Clock in the bit on the i2c interface
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	udelay(2);
+
+	value |=3D UART_EXAR_REGB_EECK;
+
+	exar_write_reg(priv, UART_EXAR_REGB, value);
+	udelay(2);
+
+	regb =3D exar_read_reg(priv, UART_EXAR_REGB);
+
+	return (regb & UART_EXAR_REGB_EEDO ? 1 : 0);
+}
+
+/**
+ * exar_ee_read() - Read a word from the EEPROM
+ * @priv: Device's private structure
+ * @ee_addr: Offset of EEPROM to read word from
+ *
+ * Read a single 16bit word from an Exar UART's EEPROM
+ *
+ * Return: EEPROM word on success, negative error code on failure
+ */
+static int exar_ee_read(struct exar8250 *priv, uint8_t ee_addr)
+{
+	int i;
+	int data =3D 0;
+
+	exar_ee_select(priv, true);
+
+	//Send read command (opcode 110)
+	exar_ee_write_bit(priv, 1);
+	exar_ee_write_bit(priv, 1);
+	exar_ee_write_bit(priv, 0);
+
+	//Send address to read from
+	for (i =3D 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>=3D 1)
+		exar_ee_write_bit(priv, (ee_addr & i));
+
+	//Read data 1 bit at a time
+	for (i =3D 0; i <=3D UART_EXAR_REGB_EE_DATA_SIZE; i++) {
+		data <<=3D 1;
+		data |=3D exar_ee_read_bit(priv);
+	}
+
+	exar_ee_select(priv, false);
+
+	return data;
+}
+
+/**
+ * exar_mpio_config() - Configure an EXar MPIO as input or output
+ * @priv: Device's private structure
+ * @mpio_num: MPIO number/offset to configure
+ * @output: Configure as output if true, inout if false
+ *
+ * Configure a single MPIO as an input or output and disable trisate.
+ * If configuring as output it is reccomended to set value with
+ * exar_mpio_set prior to calling this function to ensure default state.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int exar_mpio_config(struct exar8250 *priv,
+			unsigned int mpio_num, bool output)
+{
+	uint8_t sel_reg; //MPIO Select register (input/output)
+	uint8_t tri_reg; //MPIO Tristate register
+	uint8_t value;
+	unsigned int bit;
+
+	if (mpio_num < 8) {
+		sel_reg =3D UART_EXAR_MPIOSEL_7_0;
+		tri_reg =3D UART_EXAR_MPIO3T_7_0;
+		bit =3D mpio_num;
+	} else if (mpio_num >=3D 8 && mpio_num < 16) {
+		sel_reg =3D UART_EXAR_MPIOSEL_15_8;
+		tri_reg =3D UART_EXAR_MPIO3T_15_8;
+		bit =3D mpio_num - 8;
+	} else {
+		return -EINVAL;
+	}
+
+	//Disable MPIO pin tri-state
+	value =3D exar_read_reg(priv, tri_reg);
+	value &=3D ~(BIT(bit));
+	exar_write_reg(priv, tri_reg, value);
+
+	value =3D exar_read_reg(priv, sel_reg);
+	//Set MPIO as input (1) or output (0)
+	if (output)
+		value &=3D ~(BIT(bit));
+	else
+		value |=3D BIT(bit);
+
+	exar_write_reg(priv, sel_reg, value);
+
+	return 0;
+}
+/**
+ * exar_mpio_set() - Set an Exar MPIO output high or low
+ * @priv: Device's private structure
+ * @mpio_num: MPIO number/offset to set
+ * @high: Set MPIO high if true, low if false
+ *
+ * Set a single MPIO high or low. exar_mpio_config must also be called
+ * to configure the pin as an output.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int exar_mpio_set(struct exar8250 *priv,
+		unsigned int mpio_num, bool high)
+{
+	uint8_t reg;
+	uint8_t value;
+	unsigned int bit;
+
+	if (mpio_num < 8) {
+		reg =3D UART_EXAR_MPIOSEL_7_0;
+		bit =3D mpio_num;
+	} else if (mpio_num >=3D 8 && mpio_num < 16) {
+		reg =3D UART_EXAR_MPIOSEL_15_8;
+		bit =3D mpio_num - 8;
+	} else {
+		return -EINVAL;
+	}
+
+	value =3D exar_read_reg(priv, reg);
+
+	if (high)
+		value |=3D BIT(bit);
+	else
+		value &=3D ~(BIT(bit));
+
+	exar_write_reg(priv, reg, value);
+
+	return 0;
+}
+
+static int generic_rs485_config(struct uart_port *port, struct ktermios *=
termios,
+				struct serial_rs485 *rs485)
+{
+	bool is_rs485 =3D !!(rs485->flags & SER_RS485_ENABLED);
+	u8 __iomem *p =3D port->membase;
+	u8 value;
+
+	value =3D readb(p + UART_EXAR_FCTR);
+	if (is_rs485)
+		value |=3D UART_FCTR_EXAR_485;
+	else
+		value &=3D ~UART_FCTR_EXAR_485;
+
+	writeb(value, p + UART_EXAR_FCTR);
+
+	if (is_rs485)
+		writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
+
+	return 0;
+}
+
+static const struct serial_rs485 generic_rs485_supported =3D {
+	.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
 };

 static void exar_pm(struct uart_port *port, unsigned int state, unsigned =
int old)
@@ -182,8 +452,8 @@ static void xr17v35x_set_divisor(struct uart_port *p, =
unsigned int baud,
 	serial8250_do_set_divisor(p, baud, quot, quot_frac);

 	/* Preserve bits not related to baudrate; DLD[7:4]. */
-	quot_frac |=3D serial_port_in(p, 0x2) & 0xf0;
-	serial_port_out(p, 0x2, quot_frac);
+	quot_frac |=3D serial_port_in(p, UART_EXAR_DLD) & 0xf0;
+	serial_port_out(p, UART_EXAR_DLD, quot_frac);
 }

 static int xr17v35x_startup(struct uart_port *port)
@@ -312,15 +582,644 @@ pci_fastcom335_setup(struct exar8250 *priv, struct =
pci_dev *pcidev,
 	return 0;
 }

-static int
-pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,
-		       struct uart_8250_port *port, int idx)
+/**
+ * cti_set_tristate() - Enable/Disable RS485 transciever tristate
+ * @priv: Device's private structure
+ * @port_num: Port number to set tristate on/off
+ * @enable: Enable tristate if true, disable if false
+ *
+ * Most RS485 capable cards have a power on tristate jumper/switch that e=
nsures
+ * the RS422/RS485 transciever does not drive a multi-drop RS485 bus when=
 it is
+ * not the master. When this jumper is installed the user must set the RS=
485
+ * mode to disable tristate prior to using the port.
+ *
+ * Some Exar UARTs have an auto-tristate feature while others require set=
ting
+ * an MPIO to disable the tristate.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int cti_set_tristate(struct exar8250 *priv,
+			unsigned int port_num, bool enable)
 {
-	unsigned int offset =3D idx * 0x200;
-	unsigned int baud =3D 1843200;
+	int ret =3D 0;

-	port->port.uartclk =3D baud * 16;
-	return default_setup(priv, pcidev, idx, offset, port);
+	if (!priv || (port_num >=3D priv->nr))
+		return -EINVAL;
+
+	//Only Exar based cards use MPIO, return 0 otherwise
+	if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
+		return 0;
+
+	pci_dbg(priv->pcidev, "%s tristate for port %u\n",
+		(enable ? "enabling" : "disabling"), port_num);
+
+	ret =3D exar_mpio_set(priv, port_num, !enable);
+	if (ret)
+		return ret;
+
+	//ensure MPIO is an output
+	ret =3D exar_mpio_config(priv, port_num, true);
+
+	return ret;
+}
+
+/**
+ * cti_set_plx_int_enable() - Enable/Disable PCI interrupts
+ * @priv: Device's private structure
+ * @enable: Enable interrupts if true, disable if false
+ *
+ * Some older CTI cards require MPIO_0 to be set low to enable the PCI
+ * interupts from the UART to the PLX PCI->PCIe bridge.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int cti_set_plx_int_enable(struct exar8250 *priv, bool enable)
+{
+	int ret =3D 0;
+
+	if (!priv)
+		return -EINVAL;
+
+	//Only Exar based cards use MPIO, return 0 otherwise
+	if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
+		return 0;
+
+	pci_dbg(priv->pcidev, "%s plx fix\n",
+		(enable ? "enabling" : "disabling"));
+
+	//INT enabled when MPIO0 is LOW
+	ret =3D exar_mpio_set(priv, 0, !enable);
+	if (ret)
+		return ret;
+
+	//ensure MPIO is an output
+	ret =3D exar_mpio_config(priv, 0, true);
+
+	return ret;
+}
+
+/**
+ * cti_read_osc_freq() - Read the UART oscillator frequency from EEPROM
+ * @priv: Device's private structure
+ *
+ * CTI XR17x15X and XR17V25X cards have the serial boards oscillator freq=
uency
+ * stored in the EEPROM. FPGA and XR17V35X based cards use the PCI/PCIe c=
lock.
+ *
+ * Return: frequency on success, negative error code on failure
+ */
+static int cti_read_osc_freq(struct exar8250 *priv, uint8_t eeprom_offset=
)
+{
+	int osc_freq;
+
+	if (!priv)
+		return -EINVAL;
+
+	osc_freq =3D (exar_ee_read(priv, eeprom_offset));
+	osc_freq |=3D (exar_ee_read(priv, (eeprom_offset + 1)) << 16);
+
+	//check if EEPROM word was blank
+	if ((osc_freq =3D=3D 0xFFFF) || (osc_freq =3D=3D 0x0000))
+		return -EIO;
+
+	pci_dbg(priv->pcidev, "osc_freq from EEPROM %d\n", osc_freq);
+
+	return osc_freq;
+}
+
+static inline const char *cti_serial_port_type_to_str(enum cti_port_type =
type)
+{
+	switch (type) {
+	case CTI_PORT_TYPE_NONE:
+		return "NONE";
+	case CTI_PORT_TYPE_RS232:
+		return "RS232";
+	case CTI_PORT_TYPE_RS422_485:
+		return "RS422/485";
+	case CTI_PORT_TYPE_RS232_422_485_HW:
+		return "RS232/422/485 HW";
+	case CTI_PORT_TYPE_RS232_422_485_SW:
+		return "RS232/422/485 SW";
+	case CTI_PORT_TYPE_RS232_422_485_4B:
+		return "RS232/422/485 HW/SW (4 bit)";
+	case CTI_PORT_TYPE_RS232_422_485_2B:
+		return "RS232/422/485 HW/SW (2 bit)";
+	default:
+		break;
+	}
+
+	return "UNKNOWN";
+}
+
+/**
+ * cti_get_port_type_xr17c15x_xr17v25x() - Get the port type of a xr17c15=
x
+ * or xr17v25x card
+ *
+ * @priv: Device's private structure
+ * @port_num: Port to get type of
+ *
+ * CTI xr17c15x and xr17v25x based cards port types are based on PCI IDs
+ *
+ * Return: port type on success, CTI_PORT_TYPE_NONE on failure
+ */
+
+static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar=
8250 *priv,
+							unsigned int port_num)
+{
+	enum cti_port_type port_type;
+
+	if (!priv)
+		return CTI_PORT_TYPE_NONE;
+
+	switch (priv->pcidev->subsystem_device) {
+	//RS232 only cards
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS:
+		port_type =3D CTI_PORT_TYPE_RS232;
+		break;
+	//1x RS232, 1x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
+		port_type =3D (port_num =3D=3D 0) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	//2x RS232, 2x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
+		port_type =3D (port_num < 2) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	//4x RS232, 4x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
+		port_type =3D (port_num < 4) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	//RS232/RS422/RS485 HW (jumper) selectable
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_SP_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
+		port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
+		break;
+	//RS422/RS485 HW (jumper) selectable
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
+		port_type =3D CTI_PORT_TYPE_RS422_485;
+		break;
+	//6x RS232, 2x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
+		port_type =3D (port_num < 6) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	//2x RS232, 6x RS422/RS485
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
+		port_type =3D (port_num < 2) ?
+			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
+		break;
+	default:
+		pci_err(priv->pcidev, "unknown/unsupported device\n");
+		port_type =3D CTI_PORT_TYPE_NONE;
+	}
+
+	return port_type;
+}
+
+/**
+ * cti_get_port_type_fpga() - Get the port type of a CTI FPGA card
+ * @priv: Device's private structure
+ * @port_num: Port to get type of
+ *
+ * FPGA based cards port types are based on PCI IDs
+ *
+ * Return: port type on success, CTI_PORT_TYPE_NONE on failure
+ */
+static enum cti_port_type cti_get_port_type_fpga(struct exar8250 *priv,
+						unsigned int port_num)
+{
+	enum cti_port_type port_type;
+
+	if (!priv)
+		return CTI_PORT_TYPE_NONE;
+
+	switch (priv->pcidev->device) {
+	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
+	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
+	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
+		port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
+		break;
+	default:
+		pci_err(priv->pcidev, "unknown/unsupported device\n");
+		return CTI_PORT_TYPE_NONE;
+	}
+
+	return port_type;
+}
+
+/**
+ * cti_get_port_type_xr17v35x() - Read port type from the EEPROM
+ * @priv: Device's private structure
+ * @port_num: port offset
+ *
+ * CTI XR17V35X based cards have the port types stored in the EEPROM.
+ * This function reads the port type for a single port.
+ *
+ * Return: port type on success, CTI_PORT_TYPE_NONE on failure
+ */
+static enum cti_port_type cti_get_port_type_xr17v35x(struct exar8250 *pri=
v,
+						unsigned int port_num)
+{
+	uint16_t port_flags;
+	uint8_t offset;
+	enum cti_port_type port_type;
+
+	if (!priv)
+		return CTI_PORT_TYPE_NONE;
+
+	offset =3D CTI_EE_OFF_XR17V35X_PORT_FLAGS + port_num;
+	port_flags =3D exar_ee_read(priv, offset);
+
+	port_type =3D (port_flags & 0x00FF);
+
+	if (!CTI_PORT_TYPE_VALID(port_type)) {
+		/*
+		 * If the port type is missing the card assume it is a
+		 * RS232/RS422/RS485 card to be safe.
+		 *
+		 * There is one known board (BEG013) that only has
+		 * 3 of 4 port types written to the EEPROM so this
+		 * acts as a work around.
+		 */
+		pci_warn(priv->pcidev,
+			"failed to get port %d type from EEPROM\n", port_num);
+		port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
+	}
+
+	return port_type;
+}
+
+static int cti_rs485_config_mpio_tristate(struct uart_port *port,
+					struct ktermios *termios,
+					struct serial_rs485 *rs485)
+{
+	struct exar8250 *priv;
+	int ret;
+
+	priv =3D (struct exar8250 *)port->private_data;
+	if (!priv)
+		return -EINVAL;
+
+	ret =3D generic_rs485_config(port, termios, rs485);
+	if (ret)
+		return ret;
+
+	//disable power-on tri-state via MPIO
+	return cti_set_tristate(priv, port->port_id, false);
+}
+
+static int cti_port_setup_common(struct exar8250 *priv,
+				int idx, unsigned int offset,
+				struct uart_8250_port *port)
+{
+	int ret;
+
+	if (!priv || !port)
+		return -EINVAL;
+
+	if (priv->osc_freq =3D=3D 0)
+		return -EINVAL;
+
+	port->port.port_id =3D idx;
+	port->port.uartclk =3D priv->osc_freq;
+
+	ret =3D serial8250_pci_setup_port(priv->pcidev, port, 0, offset, 0);
+	if (ret) {
+		pci_err(priv->pcidev,
+			"failed to setup pci for port %d err: %d\n", idx, ret);
+		return ret;
+	}
+
+	port->port.private_data =3D (void *)priv;
+	port->port.pm =3D exar_pm;
+	port->port.shutdown =3D exar_shutdown;
+
+	return 0;
+}
+
+static int cti_port_setup_fpga(struct exar8250 *priv,
+				struct pci_dev *pcidev,
+				struct uart_8250_port *port,
+				int idx)
+{
+	enum cti_port_type port_type;
+	unsigned int offset;
+
+	port_type =3D cti_get_port_type_fpga(priv, idx);
+
+	pci_dbg(priv->pcidev, "Setting up CTI FPGA Port %d, Type: %s\n",
+		idx, cti_serial_port_type_to_str(port_type));
+
+	//FPGA shares port offests with XR17C15X
+	offset =3D idx * UART_EXAR_XR17C15X_PORT_OFFSET;
+	port->port.type =3D PORT_XR17D15X;
+
+	port->port.get_divisor =3D xr17v35x_get_divisor;
+	port->port.set_divisor =3D xr17v35x_set_divisor;
+	port->port.startup =3D xr17v35x_startup;
+
+	//TODO: Add support for setting line mode on cards that support it
+	if (CTI_PORT_TYPE_RS485(port_type)) {
+		port->port.rs485_config =3D generic_rs485_config;
+		port->port.rs485_supported =3D generic_rs485_supported;
+	}
+
+	return cti_port_setup_common(priv, idx, offset, port);
+}
+
+static int cti_port_setup_xr17v35x(struct exar8250 *priv,
+				struct pci_dev *pcidev,
+				struct uart_8250_port *port,
+				int idx)
+{
+	enum cti_port_type port_type;
+	unsigned int offset;
+	int ret;
+
+	port_type =3D cti_get_port_type_xr17v35x(priv, idx);
+
+	pci_dbg(priv->pcidev, "Setting up CTI XR17V35X Port %d, Type: %s\n",
+		idx, cti_serial_port_type_to_str(port_type));
+
+	offset =3D idx * UART_EXAR_XR17V35X_PORT_OFFSET;
+	port->port.type =3D PORT_XR17V35X;
+
+	port->port.get_divisor =3D xr17v35x_get_divisor;
+	port->port.set_divisor =3D xr17v35x_set_divisor;
+	port->port.startup =3D xr17v35x_startup;
+
+	switch (port_type) {
+	case CTI_PORT_TYPE_RS422_485:
+	case CTI_PORT_TYPE_RS232_422_485_HW:
+		port->port.rs485_config =3D cti_rs485_config_mpio_tristate;
+		port->port.rs485_supported =3D generic_rs485_supported;
+		break;
+	//TODO: Add support for setting line mode on cards that support it
+	case CTI_PORT_TYPE_RS232_422_485_SW:
+	case CTI_PORT_TYPE_RS232_422_485_4B:
+	case CTI_PORT_TYPE_RS232_422_485_2B:
+		port->port.rs485_config =3D generic_rs485_config;
+		port->port.rs485_supported =3D generic_rs485_supported;
+		break;
+	default:
+		break;
+	}
+
+	ret =3D cti_port_setup_common(priv, idx, offset, port);
+	if (ret)
+		return ret;
+
+	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
+	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
+	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 128);
+	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 128);
+
+	return 0;
+}
+
+static int cti_port_setup_xr17v25x(struct exar8250 *priv,
+				struct pci_dev *pcidev,
+				struct uart_8250_port *port,
+				int idx)
+{
+	enum cti_port_type port_type;
+	unsigned int offset;
+	int ret;
+
+	port_type =3D cti_get_port_type_xr17c15x_xr17v25x(priv, idx);
+
+	pci_dbg(priv->pcidev, "Setting up CTI XR17V25X Port %d, Type: %s\n",
+		idx, cti_serial_port_type_to_str(port_type));
+
+	offset =3D idx * UART_EXAR_XR17V25X_PORT_OFFSET;
+	port->port.type =3D PORT_XR17D15X;
+
+	//xr17v25x supports fractional baudrates
+	port->port.get_divisor =3D xr17v35x_get_divisor;
+	port->port.set_divisor =3D xr17v35x_set_divisor;
+	port->port.startup =3D xr17v35x_startup;
+
+	if (CTI_PORT_TYPE_RS485(port_type)) {
+		switch (priv->pcidev->subsystem_device) {
+		//These cards support power on 485 tri-state via MPIO
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
+			port->port.rs485_config =3D cti_rs485_config_mpio_tristate;
+			break;
+		//Otherwise auto or no power on 485 tri-state support
+		default:
+			port->port.rs485_config =3D generic_rs485_config;
+			break;
+		}
+
+		port->port.rs485_supported =3D generic_rs485_supported;
+	}
+
+	ret =3D cti_port_setup_common(priv, idx, offset, port);
+	if (ret)
+		return ret;
+
+	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
+	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
+	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 32);
+	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 32);
+
+	return 0;
+}
+
+static int cti_port_setup_xr17c15x(struct exar8250 *priv,
+				struct pci_dev *pcidev,
+				struct uart_8250_port *port,
+				int idx)
+{
+	enum cti_port_type port_type;
+	unsigned int offset;
+
+	port_type =3D cti_get_port_type_xr17c15x_xr17v25x(priv, idx);
+
+	pci_dbg(priv->pcidev, "Setting up CTI XR17V15X Port %d, Type: %s\n",
+		idx, cti_serial_port_type_to_str(port_type));
+
+	offset =3D idx * UART_EXAR_XR17C15X_PORT_OFFSET;
+	port->port.type =3D PORT_XR17D15X;
+
+	if (CTI_PORT_TYPE_RS485(port_type)) {
+		switch (priv->pcidev->subsystem_device) {
+		//These cards support power on 485 tri-state via MPIO
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
+		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
+			port->port.rs485_config =3D cti_rs485_config_mpio_tristate;
+			break;
+		//Otherwise auto or no power on 485 tri-state support
+		default:
+			port->port.rs485_config =3D generic_rs485_config;
+			break;
+		}
+
+		port->port.rs485_supported =3D generic_rs485_supported;
+	}
+
+	return cti_port_setup_common(priv, idx, offset, port);
+}
+
+static int cti_board_setup_xr17v35x(struct exar8250 *priv)
+{
+	if (!priv)
+		return -EINVAL;
+
+	//XR17V35X use the PCIe clock rather than crystal
+	priv->osc_freq =3D CTI_DEFAULT_PCIE_OSC_FREQ;
+
+	return 0;
+}
+
+static int cti_board_setup_xr17v25x(struct exar8250 *priv)
+{
+	int osc_freq;
+
+	if (!priv)
+		return -EINVAL;
+
+	osc_freq =3D cti_read_osc_freq(priv, CTI_EE_OFF_XR17V25X_OSC_FREQ);
+	if (osc_freq < 0) {
+		pci_warn(priv->pcidev,
+			"failed to read osc freq from EEPROM, using default\n");
+		osc_freq =3D CTI_DEFAULT_PCI_OSC_FREQ;
+	}
+
+	priv->osc_freq =3D osc_freq;
+
+	/* enable interupts on cards that need the "PLX fix" */
+	switch (priv->pcidev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
+		cti_set_plx_int_enable(priv, true);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cti_board_setup_xr17c15x(struct exar8250 *priv)
+{
+	int osc_freq;
+
+	if (!priv)
+		return -EINVAL;
+
+	osc_freq =3D cti_read_osc_freq(priv, CTI_EE_OFF_XR17C15X_OSC_FREQ);
+	if (osc_freq <=3D 0) {
+		pci_warn(priv->pcidev,
+			"failed to read osc freq from EEPROM, using default\n");
+		osc_freq =3D CTI_DEFAULT_PCI_OSC_FREQ;
+	}
+
+	priv->osc_freq =3D osc_freq;
+
+	/* enable interrupts on cards that need the "PLX fix" */
+	switch (priv->pcidev->subsystem_device) {
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
+	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
+		cti_set_plx_int_enable(priv, true);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int cti_board_setup_fpga(struct exar8250 *priv)
+{
+	int ret;
+	uint16_t cfg_val;
+
+	if (!priv)
+		return -EINVAL;
+
+	//FPGA OSC is fixed to the 33MHz PCI clock
+	priv->osc_freq =3D CTI_DEFAULT_FPGA_OSC_FREQ;
+
+	//Enable external interrupts in special cfg space register
+	ret =3D pci_read_config_word(priv->pcidev, 0x48, &cfg_val);
+	if (ret)
+		return ret;
+
+	cfg_val |=3D BIT(15);
+
+	ret =3D pci_write_config_word(priv->pcidev, 0x48, cfg_val);
+	if (ret)
+		return ret;
+
+	//RS485 gate needs to be enabled; otherwise RTS/CTS will not work
+	exar_write_reg(priv, CTI_FPGA_RS485_IO_REG, 0x01);
+
+	return 0;
 }

 static int
@@ -422,26 +1321,6 @@ static void xr17v35x_unregister_gpio(struct uart_825=
0_port *port)
 	port->port.private_data =3D NULL;
 }

-static int generic_rs485_config(struct uart_port *port, struct ktermios *=
termios,
-				struct serial_rs485 *rs485)
-{
-	bool is_rs485 =3D !!(rs485->flags & SER_RS485_ENABLED);
-	u8 __iomem *p =3D port->membase;
-	u8 value;
-
-	value =3D readb(p + UART_EXAR_FCTR);
-	if (is_rs485)
-		value |=3D UART_FCTR_EXAR_485;
-	else
-		value &=3D ~UART_FCTR_EXAR_485;
-
-	writeb(value, p + UART_EXAR_FCTR);
-
-	if (is_rs485)
-		writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
-
-	return 0;
-}

 static int sealevel_rs485_config(struct uart_port *port, struct ktermios =
*termios,
 				  struct serial_rs485 *rs485)
@@ -481,10 +1360,6 @@ static int sealevel_rs485_config(struct uart_port *p=
ort, struct ktermios *termio
 	return 0;
 }

-static const struct serial_rs485 generic_rs485_supported =3D {
-	.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
-};
-
 static const struct exar8250_platform exar8250_default_platform =3D {
 	.register_gpio =3D xr17v35x_register_gpio,
 	.unregister_gpio =3D xr17v35x_unregister_gpio,
@@ -669,6 +1544,39 @@ static irqreturn_t exar_misc_handler(int irq, void *=
data)
 	return IRQ_HANDLED;
 }

+static unsigned int exar_get_nr_ports(struct exar8250_board *board,
+					struct pci_dev *pcidev)
+{
+	unsigned int nr_ports =3D 0;
+
+	if (!board || !pcidev)
+		return 0;
+
+	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO) {
+		nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
+	} else if (board->num_ports > 0) {
+		//Check if board struct overrides number of ports
+		nr_ports =3D board->num_ports;
+	} else if (pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR) {
+		//Exar encodes # ports in last nibble of PCI Device ID ex. 0358
+		nr_ports =3D pcidev->device & 0x0f;
+	} else  if (pcidev->vendor =3D=3D PCI_VENDOR_ID_CONNECT_TECH) {
+		//Handle CTI FPGA cards
+		switch (pcidev->device) {
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
+			nr_ports =3D 12;
+			break;
+		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
+			nr_ports =3D 16;
+		default:
+			break;
+		}
+	}
+
+	return nr_ports;
+}
+
 static int
 exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
@@ -688,18 +1596,18 @@ exar_pci_probe(struct pci_dev *pcidev, const struct=
 pci_device_id *ent)

 	maxnr =3D pci_resource_len(pcidev, bar) >> (board->reg_shift + 3);

-	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO)
-		nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
-	else if (board->num_ports)
-		nr_ports =3D board->num_ports;
-	else
-		nr_ports =3D pcidev->device & 0x0f;
+	nr_ports =3D exar_get_nr_ports(board, pcidev);
+	if (nr_ports =3D=3D 0) {
+		pci_err(pcidev, "failed to get number of ports\n");
+		return -ENODEV;
+	}

 	priv =3D devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports), G=
FP_KERNEL);
 	if (!priv)
 		return -ENOMEM;

 	priv->board =3D board;
+	priv->pcidev =3D pcidev;
 	priv->virt =3D pcim_iomap(pcidev, bar, 0);
 	if (!priv->virt)
 		return -ENOMEM;
@@ -723,6 +1631,15 @@ exar_pci_probe(struct pci_dev *pcidev, const struct =
pci_device_id *ent)
 	if (rc)
 		return rc;

+	if (board->board_setup) {
+		rc =3D board->board_setup(priv);
+		if (rc) {
+			pci_err(pcidev,
+				"failed to setup serial board: %d\n", rc);
+			return rc;
+		}
+	}
+
 	for (i =3D 0; i < nr_ports && i < maxnr; i++) {
 		rc =3D board->setup(priv, pcidev, &uart, i);
 		if (rc) {
@@ -730,12 +1647,12 @@ exar_pci_probe(struct pci_dev *pcidev, const struct=
 pci_device_id *ent)
 			break;
 		}

-		dev_dbg(&pcidev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
+		pci_dbg(pcidev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			uart.port.iobase, uart.port.irq, uart.port.iotype);

 		priv->line[i] =3D serial8250_register_8250_port(&uart);
 		if (priv->line[i] < 0) {
-			dev_err(&pcidev->dev,
+			pci_err(pcidev,
 				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
 				uart.port.iobase, uart.port.irq,
 				uart.port.iotype, priv->line[i]);
@@ -753,7 +1670,8 @@ static void exar_pci_remove(struct pci_dev *pcidev)
 	unsigned int i;

 	for (i =3D 0; i < priv->nr; i++)
-		serial8250_unregister_port(priv->line[i]);
+		if (priv->line[i] >=3D 0)
+			serial8250_unregister_port(priv->line[i]);

 	/* Ensure that every init quirk is properly torn down */
 	if (priv->board->exit)
@@ -803,8 +1721,24 @@ static const struct exar8250_board pbn_fastcom335_8 =
=3D {
 	.setup		=3D pci_fastcom335_setup,
 };

-static const struct exar8250_board pbn_connect =3D {
-	.setup		=3D pci_connect_tech_setup,
+static const struct exar8250_board pbn_cti_xr17c15x =3D {
+	.board_setup	=3D cti_board_setup_xr17c15x,
+	.setup		=3D cti_port_setup_xr17c15x,
+};
+
+static const struct exar8250_board pbn_cti_xr17v25x =3D {
+	.board_setup	=3D cti_board_setup_xr17v25x,
+	.setup		=3D cti_port_setup_xr17v25x,
+};
+
+static const struct exar8250_board pbn_cti_xr17v35x =3D {
+	.board_setup	=3D cti_board_setup_xr17v35x,
+	.setup		=3D cti_port_setup_xr17v35x,
+};
+
+static const struct exar8250_board pbn_cti_fpga =3D {
+	.board_setup	=3D cti_board_setup_fpga,
+	.setup		=3D cti_port_setup_fpga,
 };

 static const struct exar8250_board pbn_exar_ibm_saturn =3D {
@@ -851,15 +1785,27 @@ static const struct exar8250_board pbn_exar_XR17V83=
58 =3D {
 	.exit		=3D pci_xr17v35x_exit,
 };

-#define CONNECT_DEVICE(devid, sdevid, bd) {				\
-	PCI_DEVICE_SUB(							\
-		PCI_VENDOR_ID_EXAR,					\
-		PCI_DEVICE_ID_EXAR_##devid,				\
-		PCI_SUBVENDOR_ID_CONNECT_TECH,				\
-		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_##sdevid), 0, 0,	\
-		(kernel_ulong_t)&bd					\
+//For Connect Tech cards with Exar vendor/device PCI IDs
+#define CTI_EXAR_DEVICE(devid, bd) {                    \
+	PCI_DEVICE_SUB(                                 \
+		PCI_VENDOR_ID_EXAR,                     \
+		PCI_DEVICE_ID_EXAR_##devid,             \
+		PCI_SUBVENDOR_ID_CONNECT_TECH,          \
+		PCI_ANY_ID), 0, 0,                      \
+		(kernel_ulong_t)&bd                     \
 	}

+//For Connect Tech cards with Connect Tech vendor/device PCI IDs (FPGA ba=
sed)
+#define CTI_PCI_DEVICE(devid, bd) {                     \
+	PCI_DEVICE_SUB(                                 \
+		PCI_VENDOR_ID_CONNECT_TECH,             \
+		PCI_DEVICE_ID_CONNECT_TECH_PCI_##devid, \
+		PCI_ANY_ID,                             \
+		PCI_ANY_ID), 0, 0,                      \
+		(kernel_ulong_t)&bd                     \
+	}
+
+
 #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd) =
}

 #define IBM_DEVICE(devid, sdevid, bd) {			\
@@ -889,18 +1835,21 @@ static const struct pci_device_id exar_pci_tbl[] =
=3D {
 	EXAR_DEVICE(ACCESSIO, COM_4SM, pbn_exar_XR17C15x),
 	EXAR_DEVICE(ACCESSIO, COM_8SM, pbn_exar_XR17C15x),

-	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_8_232, pbn_connect),
-	CONNECT_DEVICE(XR17C152, UART_1_1, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_2_2, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_4_4, pbn_connect),
-	CONNECT_DEVICE(XR17C152, UART_2, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_4, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_8, pbn_connect),
-	CONNECT_DEVICE(XR17C152, UART_2_485, pbn_connect),
-	CONNECT_DEVICE(XR17C154, UART_4_485, pbn_connect),
-	CONNECT_DEVICE(XR17C158, UART_8_485, pbn_connect),
+	CTI_EXAR_DEVICE(XR17C152,       pbn_cti_xr17c15x),
+	CTI_EXAR_DEVICE(XR17C154,       pbn_cti_xr17c15x),
+	CTI_EXAR_DEVICE(XR17C158,       pbn_cti_xr17c15x),
+
+	CTI_EXAR_DEVICE(XR17V252,       pbn_cti_xr17v25x),
+	CTI_EXAR_DEVICE(XR17V254,       pbn_cti_xr17v25x),
+	CTI_EXAR_DEVICE(XR17V258,       pbn_cti_xr17v25x),
+
+	CTI_EXAR_DEVICE(XR17V352,       pbn_cti_xr17v35x),
+	CTI_EXAR_DEVICE(XR17V354,       pbn_cti_xr17v35x),
+	CTI_EXAR_DEVICE(XR17V358,       pbn_cti_xr17v35x),
+
+	CTI_PCI_DEVICE(XR79X_12_XIG00X, pbn_cti_fpga),
+	CTI_PCI_DEVICE(XR79X_12_XIG01X, pbn_cti_fpga),
+	CTI_PCI_DEVICE(XR79X_16,        pbn_cti_fpga),

 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),

=2D-
2.43.2


